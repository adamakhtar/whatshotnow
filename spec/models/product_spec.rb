require 'rails_helper'

RSpec.describe Product, :type => :model do
  it "invalid without name or url" do
    p = Product.new
    p.valid?
    p.errors.keys.should include :name
    p.errors.keys.should include :url
  end

  it "strips params from urls" do
    p = Product.new(:url => 'www.blog.com?foo=bar')
    p.url.should == 'www.blog.com'
  end
end 
