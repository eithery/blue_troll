module PageNavigationMatchers
  class BeNavigatedToMatcher
    def initialize(expected_page)
      @page = expected_page
    end

    def matches?(page)
      page.title =~ /#{@page.title}/
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


  # Sign in page.
  class SigninPage
    def title
      'Sign in'
    end

    def to_s
      'signin page'
    end
  end

  def signin_page
    SigninPage.new
  end


  # Activation in page.
  class ActivationPage
    def title
      'Account Activation'
    end

    def to_s
      'account activation page'
    end
  end

  def activation_page
    ActivationPage.new
  end


  # Home page
  class HomePage
    def title
      'Blue Troll'
    end

    def to_s
      'home page'
    end
  end

  def home_page
    HomePage.new
  end


  # New account registration page
  class RegistrationPage
    def title
      'New User Account'
    end

    def to_s
      'new user account page'
    end
  end

  def new_user_account_page
    RegistrationPage.new
  end


  # User profile page.
  class UserProfilePage
    def initialize(user)
      @user = user
    end

    def title
      @user.name
    end

    def to_s
      "#{@user.name} user profile page"
    end
  end

  def user_profile(user)
    UserProfilePage.new(user)
  end
end
