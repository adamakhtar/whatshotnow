require 'rails_helper'

RSpec.describe StockEvent, :type => :model do
  it 'ensures name is valid' do
    build(:stock_event, name: 'blah').should_not be_valid
    build(:stock_event, name: 'size sold out').should be_valid
    build(:stock_event, name: 'size restocked').should be_valid
  end
end
