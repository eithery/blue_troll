# Eithery Lab, 2016.
# User login specs.

require 'rails_helper'

feature 'New user registration' do
  scenario 'Verify signup page layout' do
    visit signup_path

    expect(page).to have_title 'Registration'
    expect(page).to have_text 'Register to BLUE TROLLEY Club'
    expect(page).to have_field 'User login'
    expect(page).to have_field 'Password'
    expect(page).to have_field 'Password confirmation'
    expect(page).to have_field 'Email address'
    expect(page).to have_field 'Email address confirmation'
    expect(page).to have_button 'Register'
    expect(page).to have_text 'Already have an account?'
    expect(page).to have_link 'Login', href: login_path
    expect(page).to have_text 'Blue Trolley Club'
  end


  scenario 'Failed submit' do
    visit signup_path
    click_button 'Register'

    expect { click_button 'Register' }.to_not change { UserAccount.count }
  end


  scenario 'User submits empty form', js: true do
    visit signup_path
    click_button 'Register'

    expect(page).to have_title 'Registration'
    expect(page).to have_text 'User login is required and cannot be empty'
    expect(page).to have_text 'password is required and cannot be empty'
    expect(page).to have_text 'password confirmation is required'
    expect(page).to have_text 'email address is required'
    expect(page).to have_text 'email confirmation is required'
  end


  scenario 'User submits all valid information', js: true do
    visit signup_path

    fill_in :login, with: 'gwendukan'
    fill_in :email, with: 'gwen@email.com'
    fill_in :email_confirmation, with: 'gwen@email.com'
    fill_in :password, with: 'supersecret'
    fill_in :password_confirmation, with: 'supersecret'
    click_button 'Register'

    expect(page).to have_title 'gwendukan'
  end
end


=begin
    context "and submits registration form" do
      it { should be_navigated_to activation_page(user) }
      it { should display_message "New user account for #{user.login} has been created" }
    end

    context "user receives email by submit registration form" do
      specify { ->{ submit_registration_form }.should send_email(UserAccountsMailer, to: user.email,
        subject: "#{sender}: #{registered_subject}") }
    end
  end


  describe "when user is already registered" do
    let(:existing_user) { FactoryGirl.create(:active_user) }

    context "and user login already exists in DB" do
      before do
        user.login = existing_user.login.upcase
        fill_registration_form
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        it { should be_navigated_to new_user_account_page }
        specify { user.should have(1).error_on(:login) }
        it { should have_content('Login has already been taken') }
      end
    end


    context "and user email already exists in DB" do
      before do
        user.email = user.email_confirmation = existing_user.email.upcase
        fill_registration_form
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        specify { user.should have(1).error_on(:email) }
        it { should have_content('Email has already been taken') }
      end
    end
  end


private
  def fill_registration_form
    fill_in 'Login', with: user.login
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    fill_in 'Email', with: user.email
    fill_in 'Email Confirmation', with: user.email
  end

  def submit_registration_form
    click_button 'Create my account'
  end
=end