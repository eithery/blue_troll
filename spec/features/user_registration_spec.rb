require 'spec_helper'

describe "New user registration" do
  subject { page }
  before do
    visit root_path
    click_link 'Register now!'
  end

  it { should have_title('New User Account') }


  context "with valid entered information (happy path)" do
    before do
      fill_in 'Login', with: 'donreba'
      fill_in 'Password', with: 'secret'
      fill_in 'Password Confirmation', with: 'secret'
      fill_in 'Email', with: 'donreba@gmail.com'
      fill_in 'Email Confirmation', with: 'donreba@gmail.com'
      click_button 'Create my account'
    end

    it { should have_title('Account activation') }
  end
end
