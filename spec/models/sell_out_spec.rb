require 'rails_helper'

RSpec.describe SellOut, :type => :model do
  it "invalid without speed and occured_at" do
    so = SellOut.new
    so.valid?
    so.errors.keys.should include :speed
  end

  it ".create_by_inferring_speed creates record by calculating its speed from given days taken to sellout" do
    stock = create(:stock_level)
    sell_out = SellOut.create_by_inferring_speed(1.days, stock_level: stock)
    sell_out.should be_persisted
    sell_out.stock_level.should == stock
  end

  it ".infer_speed returns speed given days taken to sell out" do
    SellOut.infer_speed(1.day).should == :rapid
    SellOut.infer_speed(5.days).should == :fast
    SellOut.infer_speed(10.days).should == :quick
    SellOut.infer_speed(20.days).should == :normal
    SellOut.infer_speed(30.days).should == :slow
  end
end
