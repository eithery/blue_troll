require 'spec_helper'

describe "user_accounts/new.html.erb" do
  subject { rendered }
  let(:user) { mock_user_account.as_new_record }
  before do
    assign(:user, user)
    render
  end

  it { should have_selector("form[action='#{user_accounts_path}']") }
  it { should have_selector('legend', text: 'New User Account Registration') }

  it { should have_field('Login', text: '') }
  it { should have_field('Password', text: '') }
  it { should have_field('Password Confirmation', text: '') }
  it { should have_field('Email', text: '') }
  it { should have_field('Email Confirmation', text: '') }

  it { should have_button('Create my account') }
  it { should have_link("Can't access my account?", href: cant_access_path) }
end
