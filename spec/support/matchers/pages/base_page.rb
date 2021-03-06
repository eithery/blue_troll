module PageMatchers
  class BasePage
    def initialize(options={})
      @title = options[:title]
      @name = options[:name]
    end

    def title
      @title
    end

    def to_s
      "#{@name} page"
    end

    def verify(page)
      true
    end
  end

  def signin_page
    BasePage.new(name: 'sign in', title: 'Sign in')
  end

  def home_page
    BasePage.new(name: 'home', title: 'Blue Troll')
  end

  def new_user_account_page
    BasePage.new(name: 'new user account', title: 'New User Account')
  end

  def new_participant_page
    BasePage.new(name: 'new participant', title: 'New Participant')
  end
end
