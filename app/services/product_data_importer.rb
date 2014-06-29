class ProductDataImporter

  attr_reader :data

  def initialize(filename)
    @filename    = filename
  end

  def json
    @json ||= File.open(json_filename, 'r') do |f|
       JSON.parse(@filename).flatten
    end
  end

  def import!(seen_at=nil)
    seen_at ||= Time.now

    json.each_with_index do |prod, index|
      
      name  = prod["name"][0]
      price = prod["price"][0]
      url   = prod["url"]
      sizes = prod["sizes"]

      Product.transaction do
        begin 
          product = Product.find_or_create_by(url: url) do |p|
            p.name = name
          end
        
          Monetize.assume_from_symbol = true
          prc = Monetize.parse(price)
          product.prices.create(price: prc, seen_at: seen_at)

          sizes.each do |k, v|
            status = massage_status(v) #TODO - remove - see method definition
            tracker = StockLevelTracker.new(product, k)
            tracker.create_and_track_stock_level(status: status, seen_at: seen_at)
          end

        rescue ActiveRecord::RecordInvalid => e
          logger.error = "Could not import product data with:\n#{prod.inspect}\n#{e.message}\n\n"
        end          
      end #transaction
    end  #json.each
  end

  # TODO remove this after scrapy is updated to use new status names
  #
  def massage_status(name)
    {'available' => 'in_stock', 'zero' => 'zero_stock', 'low' => 'low_stock'}[name] || name
  end

end