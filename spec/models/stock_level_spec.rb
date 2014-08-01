require 'rails_helper'

RSpec.describe StockLevel, :type => :model do
  it "invalid without status and seen_at" do
    stock_level =  StockLevel.new
    stock_level.valid?
    stock_level.errors.keys.should include :status
    stock_level.errors.keys.should include :seen_at
  end

  it "invalid with unknown status" do
    stock_level =  build(:stock_level, status: 'bogus')
    stock_level.should_not be_valid
    stock_level.errors.keys.should include :status

    stock_level.status = 'in_stock'
    stock_level.should be_valid
  end

  it "#available_stock? returns true when either low or in stock" do
    build(:stock_level, status: 'in_stock').available_stock?.should == true
    build(:stock_level, status: 'low_stock').available_stock?.should == true
    build(:stock_level, status: 'zero_stock').available_stock?.should == false
  end

  it "#most_recent returns most recent" do
    stock_a = create(:stock_level, seen_at: 2.days.ago)
    stock_b = create(:stock_level, seen_at: 1.days.ago)
    StockLevel.most_recent.should == [stock_b, stock_a]
  end

  it ".days_between returns number of days between two given stock levels" do
    stock_a = create(:stock_level, seen_at: 2.days.ago)
    stock_b = create(:stock_level, seen_at: 1.days.ago)

    StockLevel.days_between(stock_a, stock_b).should == 1.days
  end
end
