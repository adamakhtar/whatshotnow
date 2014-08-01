class Product < ActiveRecord::Base
  
  belongs_to :retailer
  
  has_many :prices
  
  has_one  :most_recent_price, 
           -> { order('prices.seen_at DESC').limit(1) }, 
           class_name: 'Price'

  has_many :sizes

  has_many :stock_levels, 
           through: :sizes

  has_many :sell_outs, 
           through: :sizes



  scope :most_recent, 
        -> { order('updated_at DESC') }

  scope :most_hot,  
        -> { order('hotness_score DESC') }

  validates :name, presence: true, uniqueness: true
  validates :hotness_score, presence: true
  validates :url, presence: true,  uniqueness: true

  after_initialize :set_defaults

  def set_defaults
    return if persisted?
    self.hotness_score ||= 0.0
  end

  def url=(str)
    self[:url] = str.gsub(/\?.*/, '')
  end

  # perhaps we should cache this
  def last_seen_at
    mr = stock_levels.most_recent.limit(1)
    if mr.empty?
      return nil
    else
      mr.first.seen_at
    end
  end

  def first_seen_at
    mr = stock_levels.most_old.limit(1)
    if mr.empty?
      return nil
    else
      mr.first.seen_at
    end
  end

  def display_hotness_score
    (hotness_score * 100).ceil
  end
end