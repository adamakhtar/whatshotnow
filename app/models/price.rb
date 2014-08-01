class Price < ActiveRecord::Base
  
  belongs_to :product

  scope :most_recent, -> { order 'seen_at DESC' }

  register_currency :gbp

  monetize :price_cents, with_model_currency: :currency

  validates :seen_at, presence: true
end
