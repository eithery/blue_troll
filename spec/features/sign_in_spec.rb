require 'spec_helper'

shared_examples_for "user is signed out" do
  it { should have_link sign_in }
  it { should_not have_link sign_out }
end

shared_examples_for "successfully redirected to user profile page" do
  it { should have_title(user.name) }
  it { should have_link sign_out }
  it { should_not have_link sign_in }
end

shared_examples_for "sign in failed" do
  it_behaves_like "user is signed out"
  it { should have_title sign_in }
  it { should have_selector '.alert', text: 'Invalid login/password combination' }
end


describe "Sign in" do
  subject { page }
  let(:user) { FactoryGirl.create(:active_user) }
  let(:inactive_user) { FactoryGirl.create(:inactive_user) }
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
    context "based on login" do
      before { submit_form user.login }
      it_behaves_like "successfully redirected to user profile page"

      describe "followed by sign out" do
        before { click_link sign_out }
        it_behaves_like "user is signed out"
        it { should have_title('Home') }
      end
    end


    context "based on email" do
      before { submit_form user.email }
      it_behaves_like "successfully redirected to user profile page"
    end


    context "when account is not activated" do
      before { submit_form inactive_user.login }
      it_behaves_like "user is signed out"
      it { should have_title sign_in }
      it { should have_selector '.alert', text: 'User account is not activated' }
    end
  end


  context "witn invalid information" do
    context "when login does not exist" do
      before { submit_form 'incorrect_login' }
      it_behaves_like "sign in failed"
    end

    context "when email does not exist" do
      before { submit_form 'incorrect_email@gmail.com' }
      it_behaves_like "sign in failed"
    end

    context "when password is incorrect" do
      before { submit_form user.login, 'incorrect_password' }
      it_behaves_like "sign in failed"
    end
  end


private
    def submit_form(login_or_email, password=user.password)
      fill_in 'Login or Email', with: login_or_email
      fill_in 'Password', with: password
      click_button sign_in
    end
end
