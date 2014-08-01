require 'rails_helper'

RSpec.describe SellOut, :type => :model do
  it "invalid without days_taken and occured_at" do
    so = SellOut.new
    so.valid?
    so.errors.keys.should include :days_taken
    so.errors.keys.should include :occurred_at
  end
end
