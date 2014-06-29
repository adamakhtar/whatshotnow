# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    sequence(:name){|x| "Tshirt#{x}"}
    retailer
  end
end
