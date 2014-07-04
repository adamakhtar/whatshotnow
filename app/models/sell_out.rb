class SellOut < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  belongs_to :stock_level

  scope :rapid,   -> { where days_taken: (0..3) }
  scope :fast,    -> { where days_taken: (4..7) }
  scope :quick,   -> { where days_taken: (8..14) }
  scope :normal,  -> { where days_taken: (15..31) }
  scope :slow,    -> { where 'days_taken >= 32' }


  validates :days_taken, presence: true
  validates :occurred_at, presence: true

end

