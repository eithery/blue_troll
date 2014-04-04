require 'spec_helper'

describe "Sign in" do
  subject { page }
  let(:user_account) { FactoryGirl.create(:user_account) }
  let(:sign_in) { 'Sign in' }
  let(:sign_out) { 'Sign out' }
  before do
    visit root_path
    click_link sign_in
  end


  describe "navigates to sign in page" do
    it { should have_title(sign_in) }
  end


  context "with valid information" do
    shared_examples_for "user is signed out" do
      it { should have_link sign_in }
      it { should_not have_link sign_out }
    end

    shared_examples_for "successfully redirected to user profile page" do
      it { should have_title(user_account.name) }
      it { should have_link sign_out }
      it { should_not have_link sign_in }
    end


    context "based on login" do
      before { submit_form user_account.login }
      it_behaves_like "successfully redirected to user profile page"

      describe "followed by sign out" do
        before { click_link sign_out }
        it_behaves_like "user is signed out"
        it { should have_title('Home') }
      end
    end


    context "based on email" do
      before { submit_form user_account.email }
      it_behaves_like "successfully redirected to user profile page"
    end
  end


  context "witn invalid information" do
    shared_examples_for "sign in failed" do
      it_behaves_like "user is signed out"
      it { should have_title sign_in }
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
      click_button sign_in
    end
end
