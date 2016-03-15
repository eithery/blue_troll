# Eithery Lab, 2016.
# User login feature specs.

require 'rails_helper'

feature 'User login' do
  scenario 'with invalid information' do
    visit login_path
    expect(page).to have_title 'Log in'
    expect(page).to have_button 'Log In'

    click_button 'Log In'
  end
end


=begin
describe "Sign in operation" do
  subject { page }
  let(:user) { FactoryGirl.create(:active_user) }

  before do
    visit root_path
    click_link 'Sign in'
  end

  user { should_be_signed_out }
  it { should be_navigated_to signin_page }

  context "with valid information" do
    shared_examples_for "successfull sign in" do
      user { should_be_signed_in }
      it { should be_navigated_to user_profile(user) }
    end

    context "based on login" do
      context "in lower case" do
        before { submit_form user.login.downcase }
        it_behaves_like "successfull sign in"
      end

      context "in upper case" do
        before { submit_form user.login.upcase }
        it_behaves_like "successfull sign in"
      end
    end

    context "based on email" do
      context "in lower case" do
        before { submit_form user.email.downcase }
        it_behaves_like "successfull sign in"
      end

      context "in upper case" do
        before { submit_form user.email.upcase }
        it_behaves_like "successfull sign in"
      end
    end

    context "when account is not activated" do
      let(:inactive_user) { FactoryGirl.create(:inactive_user) }

      before { submit_form inactive_user.login }

      user { should_be_signed_out }
      it { should be_navigated_to signin_page }
      it { should display_warning 'User account is not activated' }
    end
  end


  context "witn invalid information" do
    shared_examples_for "failed sign in" do
      user { should_be_signed_out }
      it { should be_navigated_to signin_page }
      it { should display_warning 'Invalid login/password combination' }
    end

    context "when login does not exist" do
      before { submit_form 'incorrect_login' }
      it_behaves_like "failed sign in"
    end

    context "when email does not exist" do
      before { submit_form 'incorrect_email@gmail.com' }
      it_behaves_like "failed sign in"
    end

    context "when password is incorrect" do
      before { submit_form user.login, 'incorrect_password' }
      it_behaves_like "failed sign in"
    end
  end


private
  def submit_form(login_or_email, password=user.password)
    fill_in 'Login or Email', with: login_or_email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end
=end