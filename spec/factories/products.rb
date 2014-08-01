# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    sequence(:name){|x| "Tshirt#{x}"}
    retailer
    hotness_score 5.0
    sequence(:url){|x|  "http://topshop.com/#{x}/" }

    factory :hot_product do
      hotness_score 1000.0
    end

    factory :cold_product do
      hotness_score 1.0
    end
  end
end
