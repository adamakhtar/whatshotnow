class Inventory < ActiveRecord::Base
  belongs_to :product

  validates :size, presence: true
  validates :status, presence: true
  validates :seen_at, presence: true
end
