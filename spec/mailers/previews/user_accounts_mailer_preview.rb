# Eithery Lab, 2016.
# UserAccountsMailer preview.

class UserAccountsMailerPreview < ActionMailer::Preview
  def account_activation
    user = UserAccount.first
    user.activation_token = UserAccount.new_token
    UserAccountsMailer.account_activation user
  end
end
