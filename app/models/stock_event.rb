class StockEvent < ActiveRecord::Base

  NAMES = ['size sold out', 'size restocked']

  belongs_to :stock_level

  scope :most_recent,    -> { order('created_at DESC') }
  scope :sold_out,       -> { where name: 'size sold out' }
  scope :restocked,      -> { where name: 'size restocked' }

  validates :name, presence: true, inclusion: {in: NAMES}

  def occurred_at
    stock_level.seen_at if stock_level
  end

end
