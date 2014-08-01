require 'rails_helper'

RSpec.describe HotnessCalculator, :type => :model do

  let(:product_a){ create(:product) }
  let(:size_a)   { product_a.sizes.create(name: 'm')}
  let(:product_b){ create(:product) }
  let(:size_b)   { product_b.sizes.create(name: 'm')}

  context "#calculate" do
    it  "gives product with a faster sell out a higher score than one with slower sell out" do
      size_a.sell_outs.create(days_taken: 1, occurred_at: Time.now)
      size_b.sell_outs.create(days_taken: 2, occurred_at: Time.now)
      
      score_a = HotnessCalculator.new(product_a).calculate
      score_b = HotnessCalculator.new(product_b).calculate


      expect(score_a.finite?).to be true
      expect(score_b.finite?).to be true

      expect(score_a).to be > score_b
    end

    it  "gives product with a newer sell out a higher score than one with an older sell out" do
      size_a.sell_outs.create(days_taken: 2, occurred_at: 5.days.ago)
      size_b.sell_outs.create(days_taken: 2, occurred_at: 6.days.ago)
      
      score_a = HotnessCalculator.new(product_a).calculate
      score_b = HotnessCalculator.new(product_b).calculate

      expect(score_a.finite?).to be true
      expect(score_b.finite?).to be true
      
      expect(score_a).to be > score_b
    end
  end
end
  