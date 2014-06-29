class Product < ActiveRecord::Base
  has_many :prices
  has_many :inventories

  validates :name, presence: true
end
