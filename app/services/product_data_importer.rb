class ProductDataImporter

  attr_reader :data

  def initialize(filename)
    @filename    = filename
  end

  def json
    @json ||= File.open(@filename, 'r') do |f|
       JSON.parse(f.read).flatten
    end
  end

  def import!
    seen = [] #keep track of what products seen in this scrape report.

    json.each_with_index do |prod, index|
      

      name  = [prod["name"]].flatten.first #sometimes scraped name is stored in json as array or as a string. This ensures we get a string.
      price = [prod["price"]].flatten.first
      url   = prod["url"]
      sizes = prod["sizes"]
      seen_at = [prod["seen_at"]].flatten.first

      next if seen.include? name #skip any products that may have been included twice because they were scraped from several category lists

      Product.transaction do
        begin 
          product = Product.find_or_create_by(name: name) do |p|
            p.url = url
          end
        
          Monetize.assume_from_symbol = true
          prc = Monetize.parse(price)
          product.prices.create(price: prc, seen_at: seen_at)

          sizes.each do |k, v|
            status = massage_status(v) #TODO - remove - see method definition
            tracker = StockLevelTracker.new(product, k)
            tracker.create_and_track_stock_level(status: status, seen_at: seen_at)
          end

        rescue ActiveRecord::RecordInvalid => e
          logger.error = "Could not import product data with:\n#{prod.inspect}\n#{e.message}\n\n"
        end          
      end #transaction

      seen << name 
    end  #json.each
  end

  # TODO remove this after scrapy is updated to use new status names
  #
  def massage_status(name)
    {'available' => 'in_stock', 'zero' => 'zero_stock', 'low' => 'low_stock'}[name] || name
  end

end