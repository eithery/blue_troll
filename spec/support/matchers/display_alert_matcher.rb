module ViewMatchers
  class DisplayAlertMatcher
    def initialize(message, type)
      @message = message
      @message_type = type
    end

    def matches?(page)
      page.has_selector?(".alert.alert-#{alert_type}", text: @message)
    end

    def description
      "display #{@message_type.to_s}"
    end

    def failure_message
      "page does NOT display #{@message_type.to_s} '#{@message}'"
    end

  private
    def alert_type
      case @message_type
        when :message then 'success'
        when :warning then 'warning'
        when :error then 'danger'
      end
    end
  end


  def display_message(message)
    DisplayAlertMatcher.new(message, :message)
  end

  def display_warning(message)
    DisplayAlertMatcher.new(message, :warning)
  end

  def display_error(message)
    DisplayAlertMatcher.new(message, :error)
  end
end
