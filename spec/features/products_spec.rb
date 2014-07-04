require 'rails_helper'


feature 'products' do
  let(:user) { create(:user) }

  scenario 'listing all products shows products recently updated first' do

    sign_in(user)

    product_a = create(:product, updated_at: 10.days.ago)
    product_b = create(:product, updated_at: 1.days.ago)
    product_c = create(:product, updated_at: 4.days.ago)

    visit products_path

    click_link 'All'

    assert_seen('All Products', within: :page_header)
    assert_seen(product_b.name, within: :first_product)
    assert_seen(product_c.name, within: :second_product)
  end

  scenario 'listing hot products shows hot products' do
    sign_in user

    cold_product  = create(:cold_product)
    hot_product   = create(:hot_product)

    visit products_path

    click_link 'Hot'

    assert_seen('Hot Products', within: :page_header)
    assert_seen(hot_product.name, within: :first_product)
    assert_seen(cold_product.name, within: :second_product)
  end

  scenario 'viewing single product' do
    product = create(:product)
    sign_in user
    
    visit product_path product
    page.current_path.should == product_path(product)
    assert_seen product.name, within: :page_header
  end

end