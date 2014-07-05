module ProductsHelper
  def product_tab(title, opts={})
    content_tag :li, :class => opts[:active] ? 'active' : '' do
      link_to title, products_path(tab: title)
    end
  end
end
