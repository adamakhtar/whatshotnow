require 'rails_helper'


RSpec.describe StockLevelTracker, :type => :model do
  let(:product) { create(:product) }
  let(:size)    { create(:size, product: product) }
  let(:tracker) { StockLevelTracker.new(product, size.name) }
  

  describe "#create_and_track_stock_level" do

    it "creates size if it didnt exist" do
      size_name = 'xlarge'
      t = StockLevelTracker.new(product, size_name)

      new_size = t.size
      new_size.name.should == size_name
      new_size.product.should == product
    end

    it "creates stock_level for given size" do
      time_now = Time.now.utc
      stock_level = tracker.create_and_track_stock_level(status: 'in_stock', seen_at: time_now)
      stock_level.should be_valid
      stock_level.seen_at.should  == time_now
      stock_level.status.should   == 'in_stock'
      stock_level.size.should     == size
    end

    context "when size just sold out" do
      before do 
        previous_level = create(:stock_level, size: size, status: 'in_stock', seen_at: 1.days.ago)
        @stock_level = tracker.create_and_track_stock_level(status: 'zero_stock', seen_at: Time.now.utc)
      end
      
      it "creates a sell out" do
        @stock_level.sell_out.should be_a SellOut
      end

      it "creates a sold out event" do
        @stock_level.events.count.should == 1
        @stock_level.events.first.name.should == 'size sold out'
      end
    end

    context "when size just restocked" do
      before do
        previous_level = create(:stock_level, size: size, status: 'zero_stock', seen_at: 1.days.ago)
        @stock_level = tracker.create_and_track_stock_level(status: 'in_stock', seen_at: Time.now.utc)
      end

      it "does not create a sell out" do
        @stock_level.sell_out.should be_nil
      end

      it "creates a restocked event" do
        @stock_level.events.count.should == 1
        @stock_level.events.first.name.should == 'size restocked'
      end
    end

  end
end
