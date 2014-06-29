require 'rails_helper'

RSpec.describe ProductDataImporter, :type => :model do
  it "imports data from json file" do
    time_now = Time.now.utc
    importer = ProductDataImporter.new("somefile.json")

    importer.stub json: JSON.parse( %Q*[{"url": "http://www.topshop.com/blah", "price": ["\u00a380.00"], "name": ["Floral Weave Shift Dress by Boutique"], "sizes": {"4": "available", "6": "zero"}}]*)
    
    importer.import!(time_now)

    Product.count.should == 1
    product = Product.first
    
    product.prices.count.should == 1
    price   = product.prices.first
    price.price.should == Money.new(8000, 'GBP')
    price.seen_at.should == time_now

    product.inventories.count.should == 2
    product.inventories.where(size: '4').first.status.should == 'available'
    product.inventories.where(size: '4').first.seen_at.should == time_now
    product.inventories.where(size: '6').first.status.should == 'zero'
    product.inventories.where(size: '6').first.seen_at.should == time_now
  end
end 
