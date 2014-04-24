def sign_in(user)
  visit signin_path
  fill_in 'Login or Email', with: user.login
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end
