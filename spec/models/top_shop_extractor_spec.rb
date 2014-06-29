
describe TopShopExtractor do

  before do
    VCR.use_cassette 'extractor/top_shop_size_grid' do
      @extractor = TopShopExtractor.parse("http://www.topshop.com/en/tsuk/product/clothing-427/tops-443/strappy-pleat-cami-3040603?bi=1&ps=20")
    end
  end
  
  it "extracts product title" do
    @extractor.title.should == "STRAPPY PLEAT CAMI"
  end


end