require 'rails_helper'


feature 'products' do
  let(:user) { create(:user) }
  let(:retailer){ create(:retailer) }



  scenario 'listing all products shows products recently updated first' do

    sign_in(user)

    product_a = create(:product, retailer: retailer, updated_at: 10.days.ago)
    product_b = create(:product, retailer: retailer, updated_at: 1.days.ago)
    product_c = create(:product, retailer: retailer, updated_at: 4.days.ago)

    visit products_path(retailer)

    assert_seen('All Products', within: :page_header)
    assert_seen(product_b.name, within: :first_product)
    assert_seen(product_c.name, within: :second_product)
  end

  scenario 'viewing single product' do
    product = create(:product)
    sign_in user
    
    visit product_path product
    page.current_path.should == product_path(product)
    assert_seen product.name, within: :page_header
  end

end