module ProductsHelper
  def product_tab(title, opts={})
    content_tag :li, :class => opts[:active] ? 'active' : '' do
      link_to title, products_path(tab: title)
    end
  end

  def time_difference_in_days(date)
    (Time.now - date).to_i / 1.day 
  end 
end
