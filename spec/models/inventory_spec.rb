require 'rails_helper'

RSpec.describe Inventory, :type => :model do
  it "invalid without size, status and seen_at" do
    inventory =  Inventory.new
    inventory.valid?
    inventory.errors.keys.should include :size
    inventory.errors.keys.should include :status
    inventory.errors.keys.should include :seen_at
  end
end
