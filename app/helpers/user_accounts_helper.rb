module UserAccountsHelper
  def gravatar_for(user_account)
    gravatar_id = Digest::MD5::hexdigest(user_account.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user_account.email, class: "gravatar")
  end
end
