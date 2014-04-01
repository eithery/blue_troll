require 'spec_helper'

describe "Authentication" do
  describe "sign in" do
    let(:user_account) { FactoryGirl.create(:user_account) }
    subject { page }
    before do
      visit root_path
      click_link 'Sign in'
    end

    it { should have_title('Sign in') }


    context "with valid information" do
      shared_examples_for "successfully redirected to user profile page" do
        it { should have_title(user_account.name) }
        it { should have_link 'Sign out' }
        it { should_not have_link 'Sign in' }
      end


      context "based on login" do
        before { submit_form user_account.login }
        it_behaves_like "successfully redirected to user profile page"
      end

      context "based on email" do
        before { submit_form user_account.email }
        it_behaves_like "successfully redirected to user profile page"
      end
    end


    context "witn invalid information" do
      shared_examples_for "sign in failed" do
        it { should have_title 'Sign in' }
        it { should_not have_link 'Sign out' }
        it { should have_link 'Sign in' }
        it { should have_selector 'div.alert', text: 'Invalid login/password combination' }
      end


      context "when login does not exist" do
        before { submit_form 'incorrect_login' }
        it_behaves_like "sign in failed"
      end

      context "when email does not exist" do
        before { submit_form 'incorrect_email@gmail.com' }
        it_behaves_like "sign in failed"
      end

      context "when password is incorrect" do
        before { submit_form user_account.login, 'incorrect_password' }
        it_behaves_like "sign in failed"
      end
    end


private
    def submit_form(login_or_email, password=user_account.password)
      fill_in 'Login or Email', with: login_or_email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
