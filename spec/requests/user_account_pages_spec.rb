require 'spec_helper'

describe "User account pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_title 'Blue Troll | New User Account' }
    it { should have_selector 'legend', text: 'New User Account Registration' }
    it { should have_field 'Login' }
    it { should have_field 'Password' }
    it { should have_field 'Password Confirmation' }
    it { should have_field 'Email' }
    it { should have_field 'Email Confirmation' }
    it { should have_button 'Create my account' }

    it_behaves_like "Page with header"
    it_behaves_like "Page with footer"
  end


  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    context "with invalid information" do
      it "should not create a user account" do
        expect { click_button submit }.not_to change(UserAccount, :count)
      end
    end


    context "with valid information" do
      before do
        fill_in 'Login', with: 'maryikaro'
        fill_in 'Email', with: 'maryika@gmail.com'
        fill_in 'Email Confirmation', with: 'maryika@gmail.com'
        fill_in 'Password', with: 'foobar123'
        fill_in 'Password Confirmation', with: 'foobar123'
      end

      it "should create a user account" do
        expect { click_button submit }.to change(UserAccount, :count).by(1)
      end
    end
  end


  describe "profile page" do
    let(:user_account) { FactoryGirl.create(:user_account) }
    before { visit user_account_path(user_account) }

    it { should have_title "Blue Troll | #{user_account.name} profile" }

    it_behaves_like "Page with header"
    it_behaves_like "Page with footer"
  end
end
