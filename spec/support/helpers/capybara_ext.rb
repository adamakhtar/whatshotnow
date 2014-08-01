module Features
  module CapybaraExt

    # Just a shorter way of writing it.
    def assert_seen(text, opts={})
      if opts[:within]
        within(selector_for(opts[:within])) do
          page.should have_content(text)
        end
      else
        page.should have_content(text)
      end
    end

    def flash_alert!(text)
      within(".alert") do
        assert_seen(text)
      end
    end

    def flash_notice!(text)
      within(".notice") do
        assert_seen(text)
      end
    end

    def selector_for(identifier)
      case identifier
      when :page_header 
        '.page-header'
      when :products 
        '.products-list'
      when :first_product
        '.product:nth-child(1)'
      when :second_product
        '.product:nth-child(2)'
      else
        pending "No selector defined for #{identifier}. Please define one in spec/support/capybara_ext.rb"
      end
    end

    # Just shorter to type.
    def page!
      save_and_open_page
    end  
  end
end
