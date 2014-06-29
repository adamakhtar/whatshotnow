require 'rails_helper'

RSpec.describe Size, :type => :model do
  
  let(:size){ create(:size) }

  it 'invalid with duplicate name' do
    p = create(:product)
    create(:size, name: 'm', product: p)

    s = Size.new(name: 'm', product: p)
    s.should_not be_valid
    s.errors.keys.should include :name
  end

  context "#just_sold_out?" do
    it "returns true when current stock level is only stock level and zero stock" do
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 4.day.ago)
      size.just_sold_out?.should == true
    end

    it "returns false when current stock level is only stock level and available stock" do
      create(:stock_level, size: size, status: 'in_stock', seen_at: 4.day.ago)
      size.just_sold_out?.should == false
    end

    it "returns true when previously stock was available but now zero stock" do
      create(:stock_level, size: size, status: 'in_stock', seen_at: 6.days.ago)
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 4.day.ago)
      size.just_sold_out?.should == true
    end

    it "returns false when previously stock was zero and now also zero" do
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 6.days.ago)
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 2.days.ago)
      size.just_sold_out?.should == false
    end
  end


  context "#just_restocked?" do
    it "returns true when current stock level is only stock level and available stock" do
      create(:stock_level, size: size, status: 'in_stock', seen_at: 4.day.ago)
      size.just_restocked?.should == true
    end

    it "returns false when current stock level is only stock level and zero stock" do
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 4.day.ago)
      size.just_restocked?.should == false
    end

    it "returns true when previously stock was zero but now available" do
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 6.days.ago)
      create(:stock_level, size: size, status: 'in_stock', seen_at: 4.day.ago)
      size.just_restocked?.should == true
    end

    it "returns false when previously stock was available and now zero" do
      create(:stock_level, size: size, status: 'in_stock', seen_at: 6.days.ago)
      create(:stock_level, size: size, status: 'zero_stock', seen_at: 2.days.ago)
      size.just_restocked?.should == false
    end
  end

  context "#days_since_last_restock" do
    it "returns correct time in days" do
      stock_level = create(:stock_level, size: size, status: 'in_stock', seen_at: 6.days.ago)
      stock_level.events.create(name: 'size restocked')
      size.days_since_last_restock.should == 6
    end
  end
end
