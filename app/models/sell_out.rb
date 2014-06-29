class SellOut < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  belongs_to :stock_level

  scope :rapid,   -> { where speed: 'rapid' }
  scope :fast,    -> { where speed: 'fast' }
  scope :quick,    -> { where speed: 'quick' }
  scope :normal,  -> { where speed: 'normal' }
  scope :slow,    -> { where speed: 'slow' }

  validates :speed, presence: true

  def self.create_by_inferring_speed(days_taken, args)
    args = args.reverse_merge(speed: infer_speed(days_taken))
    create(args)
  end

  def self.infer_speed(days_taken)
    speed = case days_taken
    when (0.days..3.days)  then :rapid
    when (4.days..7.days)  then :fast
    when (8.days..14.days) then :quick 
    when (15.days..21.days) then :normal
    else 
      :slow
    end
  end
end

