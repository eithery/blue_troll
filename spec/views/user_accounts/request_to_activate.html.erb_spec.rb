require 'spec_helper'

describe "user_accounts/request_to_activate.html.erb" do
  subject { rendered }
  let(:user) { stub_model(UserAccount, login: 'johnsmith', name: 'johnsmith', email: 'johnsmith@gmail.com') }
  before do
    assign(:user, user)
    render
  end

  it { should have_content("Hello #{user.login}, welcome to Blue Trolley club!") }
  it { should have_content('Your registration has been successful.') }
  it { should have_content("The email is sent to the following address: #{user.email}") }
  it { should have_selector("form[action='#{activate_path}']") }

  it { should have_field('Activation Code:') }
  it { should have_button('Activate my account') }
  it { should have_content('No email received?') }
  it { should have_link('here', href: '#') }
end
