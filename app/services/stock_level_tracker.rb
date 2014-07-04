class StockLevelTracker

  def initialize(product, size_name)
    @product   = product
    @size_name = size_name
  end

  # Creates stock_level for size and records any sell outs 
  # and records stock change events
  #
  def create_and_track_stock_level(attr={})
    stock_level  = size.stock_levels.create(attr)
    
    if stock_level.valid?
      if size.just_sold_out?
        #fire sold out
        stock_level.events.create(name: 'size sold out')

        #create a sellout
        days_taken = size.days_since_last_restock
        SellOut.create(days_taken: days_taken, size: size, stock_level: stock_level)

      elsif size.just_restocked?
        #fire restocked event
        stock_level.events.create(name: 'size restocked')
      end
    end

    stock_level
  end

  def size
     @size ||= @product.sizes.find_or_create_by(name:  @size_name)
  end

end
