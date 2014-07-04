require 'highline/import'
require 'json'

namespace :db do

  desc "import product information from json file"
  task :import_data, [:filename]  do |t, args|
    
    seen_at = Time.now.ufc
      
    File.open(args[:filename], 'r') do |f|
      data = JSON.parse(file)
    end

    data = data.flatten #remove uneccesary nesting
    
    data.each_with_index do |prod, index|

      name  = prod[:name][0]
      price = prod[:price][0]
      url   = prod[:url]
      sizes = prod[:sizes]

      Product.transaction do

        begin 
          product = Product.find_or_create_by_url(url: url, name: name)

          prc = Monetize.parse(price)
          product.prices.create(price: prc, seen_at: seen_at)

          sizes.each do |k, v|
            product.inventories.create(size: k, status: v, seen_at: seen_at)
          end

        rescue ActiveRecord::RecordInvalid => e
          logger.error = "Could not import product data with:\n#{prod.inspect}\n#{e.message}\n\n"
        end          

        puts "Processed #{(index + 1).to_s}"
      end 
    end 

    puts "Import data complete.\n\n"
  end

  desc 'calculate hotness score for all products'
  task :calculate_hotness do
    Product.find_each do |p|
      p.hotness_score = HotnessCalculator.new(p).calculate
      p.save
    end 
  end

end
