# Gives product a hotness score. The score is determined by
# how many sellouts a product has. In particular products which 
# have sellouts that are:
# - more recent
# - faster in time taken 
# - numerous
#
# will have a better hotness score.

class HotnessCalculator

  def initialize(product)
    @product = product
  end

  def calculate
    score = 0


    @product.sell_outs.each do |so|
      score += 1 / Math.log10(sell_out_age(so))
      score += 1 / Math.log10(so.days_taken)
    end

    score
  end

  def sell_out_age(sell_out)
    (Time.now.to_date - sell_out.occurred_at.to_date)
  end
end