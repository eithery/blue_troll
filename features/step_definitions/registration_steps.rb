Given(/^the person who is not registered$/) do
  user_account = UserAccount.find_by_email('maryika@gmail.com')
  user_account.should be_nil
end


When(/^the user visits Blue Troll home page$/) do
  visit root_path
end


When (/^she starts new user registration process$/) do
  click_link 'Register now!'
end


When(/^she fills up and submit the registration form correctly$/) do
  fill_in 'Login', with: 'Maryika'
  fill_in 'Password', with: 'secret123'
  fill_in 'Password Confirmation', with: 'secret123'
  fill_in 'Email', with: 'maryika@gmail.com'
  fill_in 'Email Confirmation', with: 'maryika@gmail.com'
  click_button 'Create my account'
end


Then(/^the new user account is created$/) do
  user_account = UserAccount.find_by_email('maryika@gmail.com')
  user_account.should_not be_nil
  user_account.login.should == 'maryika'
end


Then(/^the user sees congratulation message and account activation instructions$/) do
end
