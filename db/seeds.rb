# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

size_names = %w{medium}



#create a hot product
p = Product.create!(name: 'Hot Leather Jacket')

stock_levels = [
  {status: 'in_stock', seen_at: 7.days.ago},
  {status: 'low_stock', seen_at: 3.days.ago},
  {status: 'zero_stock', seen_at: 1.day.ago}
]

size_names.map do |name|
    stock_levels.each do |sl| 
      StockLevelTracker.new(p, name).create_and_track_stock_level(sl)
   end
end


#create a cold product
p = Product.create!(name: 'Boring Tank Top')

stock_levels = [
  {status: 'in_stock', seen_at: 4.weeks.ago},
  {status: 'low_stock', seen_at: 3.weeks.ago},
  {status: 'zero_stock', seen_at: 1.week.ago}
]

size_names.map do |name|
   
   size_names.map do |name|
       stock_levels.each do |sl| 
         StockLevelTracker.new(p, name).create_and_track_stock_level(sl)
      end
   end
  
end





