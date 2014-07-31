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
    total_score = 0
    return total_score unless @product.sell_outs.count > 0
  
    @product.sell_outs.each do |so|

      # score is produt of sellouts age and its speediness to occur
      # the older it is, the lower its score will be 
      # the longer it took to sellout, the lower its score will be
      # perfect situation of being a recent sellout and fast will yield higher score.

      total_score += age_score(so)
      total_score += days_taken_score(so)
    end

    # divide by number of sizes to find the average score

    total_score = total_score / @product.sizes.count if total_score > 0.0
    total_score
  end

  # how many days ago did sell out occur
  def days_old(sell_out)
    (Time.now - sell_out.occurred_at).to_i / 1.day
  end

  # sell outs which occured more recently get higher score
  # 0.0 ~ 1.0
  def age_score(sell_out)
    score = 1.0 /([days_old(sell_out), 1].max)**0.15
    score 
  end

  # sellouts which took less time get higher score
  # 0.0 ~ 1.0
  def days_taken_score(sell_out)

    # at power of 0.15 a product gets following scores for various speeds
    # 1 day  = 1.0
    # 2 days = 0.9
    # 7 days = 0.74
    # 14 days = 0.67
    # Look at actual results and tweak the power if this is to strict or lenient
    score = 1.0 / ([sell_out.days_taken, 1].max)**0.15
    score 
  end
end