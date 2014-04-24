module PageMatchers
  class BeNavigatedToMatcher
    def initialize(expected_page)
      @page = expected_page
    end

    def matches?(page)
      page.title =~ /#{@page.title}/ && @page.verify(page)
    end

    def description
      "navigate to #{@page}"
    end

    def failure_message
      "the current page is NOT #{@page}"
    end
  end

  def be_navigated_to(expected_page)
    BeNavigatedToMatcher.new(expected_page)
  end
end
