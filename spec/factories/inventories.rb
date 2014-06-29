# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    size "MyString"
    status "MyString"
    seen_at "MyString"
    product_id 1
  end
end
