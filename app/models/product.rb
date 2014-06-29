class Product < ActiveRecord::Base
  belongs_to :retailer
  has_many :prices
  has_many :sizes
  has_many :stock_levels, through: :sizes
  has_many :sell_outs, through: :sizes

  scope :most_recent, -> { order('updated_at DESC') }
  
  validates :name, presence: true, uniqueness: true
end
