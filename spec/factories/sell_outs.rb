# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sell_out do
    occured_at "2014-06-29 16:05:36"
    days_taken 3
    inventory_id 1
  end
end
