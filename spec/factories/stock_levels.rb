# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_level do
    status 'in_stock'
    seen_at Time.now.utc
  end
end
