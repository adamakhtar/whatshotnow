class Product < ActiveRecord::Base
  has_many :prices
  has_many :sizes
  has_many :stock_levels, through: :sizes
  has_many :sell_outs, through: :sizes

  validates :name, presence: true
end
