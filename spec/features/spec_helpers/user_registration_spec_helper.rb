module UserRegistrationSpecHelper
  def register(user_account)
    visit_registration_page
    fill_registration_form(user_account)
    submit_registration_form
  end


  def visit_registration_page
    visit root_path
    click_link 'Register now!'
  end


  def fill_registration_form(user_account)
    fill_in 'Login', with: user_account.login
    fill_in 'Password', with: user_account.password
    fill_in 'Password Confirmation', with: user_account.password
    fill_in 'Email', with: user_account.email
    fill_in 'Email Confirmation', with: user_account.email
  end


  def submit_registration_form
    click_button 'Create my account'
  end
end
