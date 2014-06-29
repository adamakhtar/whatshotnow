class Size < ActiveRecord::Base
  belongs_to :product
  has_many :stock_levels
  has_many :events, through: :stock_levels
  has_many :sell_outs

  validates :name, presence: true, uniqueness: {scope: :product}

  def just_sold_out?
    current_stock, previous_stock = stock_levels.most_recent[0..1]
  
    if previous_stock
      current_stock.zero_stock? and previous_stock.available_stock?
    else
      current_stock.zero_stock?
    end
  end

  def just_restocked?
    current_stock, previous_stock = stock_levels.most_recent[0..1]

    if previous_stock
      current_stock.available_stock? and previous_stock.zero_stock?
    else
      current_stock.available_stock?
    end
  end

  def days_since_last_restock
    restocked = events.restocked.most_recent.first
    return unless restocked
    (Time.now.to_date - restocked.occurred_at.to_date).to_i
  end
end
