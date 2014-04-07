module UserRegistrationHelper
  def register(user_account)
    visit root_path
    click_link 'Register now!'

    fill_in 'Login', with: user_account.login
    fill_in 'Password', with: user_account.password
    fill_in 'Password Confirmation', with: user_account.password
    fill_in 'Email', with: user_account.email
    fill_in 'Email Confirmation', with: user_account.email

    click_button create_account
  end
end
