require 'spec_helper'

describe "User account activation" do
  let(:user) { FactoryGirl.build(:inactive_user) }
  let(:create_account) { 'Create my account' }
  before do
    visit root_path
    click_link 'Register now!'

    fill_in 'Login', with: user.login
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    fill_in 'Email', with: user.email
    fill_in 'Email Confirmation', with: user.email

    click_button create_account
  end

  describe "with correct activation code" do
    before do
      inactive_user = UserAccount.find_by_email(user.email)
      fill_in 'Activation Code', with: inactive_user.activation_code
      click_button 'Activate my account'
    end

    describe "user account" do
      subject { active_user }
      let(:active_user) { UserAccount.find_by_email(user.email) }
      it { should be_active }
    end

    describe "navigated page" do
      subject { page }
      it { should have_title('Sign in') }
      it { should have_selector('.alert-success',
        text: 'Congratulation! Your account has been successfully activated') }
    end
  end


  describe "with incorrect activation code" do
    let(:incorrect_code) { '123456' }
    before do
      fill_in 'Activation Code', with: incorrect_code
      click_button 'Activate my account'
    end

    describe "user account" do
      subject { active_user }
      let(:active_user) { UserAccount.find_by_email(user.email) }
      it { should_not be_active }
    end

    describe "navigated page" do
      subject { page }
      it { should have_title('Account Activation') }
      it { should have_selector('.alert-warning', text: 'Incorrect activation code') }
    end
  end


  describe "with correct activation link" do
  end


  describe "with incorrect activation link" do
  end
end
