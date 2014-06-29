require 'rails_helper'

RSpec.describe ProductDataImporter, :type => :model do
  it "imports data from json file" do
    time_now = Time.now
    importer = ProductDataImporter.new("somefile.json")

    importer.stub json: JSON.parse( %Q*[{"url": "http://www.topshop.com/blah", "price": ["\u00a380.00"], "name": ["Floral Weave Shift Dress by Boutique"], "sizes": {"4": "available", "6": "zero"}}]*)
    
    importer.import!(time_now)

    Product.count.should == 1
    product = Product.first
    
    product.prices.count.should == 1
    price   = product.prices.first
    price.price.should == Money.new(8000, 'GBP')
    price.seen_at.should == time_now

    product.sizes.count.should == 2
    product.stock_levels.count.should == 2
    

    size_4 = product.sizes.where(name: '4').first
    size_6 = product.sizes.where(name: '6').first

    size_4.stock_levels.first.status.should == 'in_stock'
    size_4.stock_levels.first.seen_at.should == time_now
    
    size_6.stock_levels.first.status.should == 'zero_stock'
    size_6.stock_levels.first.seen_at.should == time_now
  end
end 

