# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retailer do
    sequence(:name){|x| "Topshop#{x}"}
  end
end
