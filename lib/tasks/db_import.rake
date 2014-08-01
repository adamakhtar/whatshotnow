require 'highline/import'
require 'json'

namespace :db do

  desc "import product information from json file"
  task(:import_data, [:filename, :seen_at] => :environment) do |t, args|
    
    seen_at = Date.parse(args[:seen_at]) || Time.now.ufc
      
    ProductDateImporter.new(args[:filename]).import!(seen_at)
    
    puts "Import data complete.\n\n"
  end

  desc 'calculate hotness score for all products'
  task :calculate_hotness => :environment do
    Product.find_each do |p|
      p.hotness_score = HotnessCalculator.new(p).calculate
      p.save
    end 
  end

  desc "Bootstrap is: migrating, loading defaults, sample data and seeding (for all extensions) and load_products tasks"
  task :bootstrap  do
    

    # remigrate unless production mode (as saftey check)
    if %w[development test].include? Rails.env
      if agree("This task will destroy any data in the database. Are you sure you want to \ncontinue? [y/n] ")
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        Rake::Task["db:migrate"].invoke
      else
        say "Task cancelled, exiting."
        exit
      end
    else
      say "NOTE: Bootstrap in production mode will not drop database before migration"
      Rake::Task["db:migrate"].invoke
    end

    ActiveRecord::Base.send(:subclasses).each do |model|
      model.reset_column_information
    end

    load_defaults  = User.count == 0

    if load_defaults
      User.create( email: 'adamsubscribe@googlemail.com',
                   password: 'changethis',
                   password_confirmation: 'changethis' )
    end

    if Rails.env.development? and agree("Load sample data?[y/n]")

      Rake::Task["db:seed"].invoke

    end

    puts "Bootstrap Complete.\n\n"
  end
end
