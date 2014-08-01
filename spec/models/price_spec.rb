require 'rails_helper'

RSpec.describe Price, :type => :model do
  it "invalid without price and seen_at" do
    p = Price.new
    p.valid?
    p.errors.keys.should include :price_cents
    p.errors.keys.should include :seen_at
  end
end
