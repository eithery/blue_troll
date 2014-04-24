module PageMatchers
  class UserProfilePage < BasePage
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
    UserProfilePage.new user
  end
end
