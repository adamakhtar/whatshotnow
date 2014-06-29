require 'rails_helper'

RSpec.describe Product, :type => :model do
  it "invalid without name" do
    p = Product.new
    p.valid?
    p.errors.keys.should include :name
  end
end 
