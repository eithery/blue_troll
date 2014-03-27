Given(/^the person who is not registered$/) do
  user_account = UserAccount.find_by_email('unregistered@gmail.com')
  user_account.should be_nil
end


When(/^the user visits Blue Troll home page$/) do
  visit root_path
end


When (/^she starts new user registration process$/) do
  click_link 'Register now!'
end


When(/^she fills up the registration form correctly$/) do
  fill_in 'Login', with: ''
  fill_in 'Email', with: ''
end
