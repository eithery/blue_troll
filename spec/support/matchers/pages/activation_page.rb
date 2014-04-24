require_relative 'base_page'

module PageMatchers
  class AccountActivationPage < BasePage
    def initialize(user)
      @user = user
    end

    def title
      'Account Activation'
    end

    def to_s
      "account activation page"
    end

    def verify(page)
      page.has_content?("Hello #{@user.login}, welcome to Blue Trolley club!") &&
      page.has_content?("Within few minutes, you will receive an email " +
        "with your activation link and activation code.") &&
      page.has_content?("The email is sent to the following address: #{@user.email}") &&
      page.has_content?("In order to activate your account enter the code or " +
        "click on the link in your email.")
    end
  end

  def activation_page(user)
    AccountActivationPage.new user
  end
end
