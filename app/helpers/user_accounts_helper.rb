# Eithery Lab, 2016.
# UserAccountsHelper.
# Represents a helper class for user accounts views.

module UserAccountsHelper
  def gravatar_for(user_account, size: 48)
    gravatar_id = Digest::MD5::hexdigest(user_account.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user_account.name, class: 'img-circle')
  end


  def user_participants
    @user.participants.order(:last_name, :first_name)
  end
end
