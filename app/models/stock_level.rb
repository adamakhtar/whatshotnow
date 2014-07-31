class StockLevel < ActiveRecord::Base
  belongs_to :product
  belongs_to :size

  has_one :sell_out, dependent: :destroy
  has_many :events, class_name: 'StockEvent', dependent: :destroy

  STATUS_NAMES = %w{in_stock low_stock zero_stock}
  
  scope :most_recent,   -> { order('seen_at DESC') }
  scope :most_old,      -> { order('seen_at ASC')}
  scope :in_stock,      -> { where status: 'in_stock' }
  scope :low_stock,     -> { where status: 'low_stock' }
  scope :zero_stock,    -> { where status: 'zero_stock' }

  validates :status, presence: true, inclusion: {in: STATUS_NAMES}
  validates :seen_at, presence: true

  def self.days_between(a, b)
    (a.seen_at.to_date - b.seen_at.to_date).to_i.abs.days
  end

  def zero_stock?
    status == 'zero_stock'
  end

  def low_stock?
    status == 'low_stock'
  end

  def in_stock?
    status == 'in_stock'
  end

  def available_stock?
    in_stock? or low_stock?
  end



end
