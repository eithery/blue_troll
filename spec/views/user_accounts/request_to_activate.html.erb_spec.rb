require 'spec_helper'

describe "user_accounts/request_to_activate.html.erb" do
  subject { rendered }
  let(:user_login) { 'johnsmith' }
  let(:user_email) { 'johnsmith@gmail.com' }
  before do
    assign(:user, stub_model(UserAccount, name: user_login, email: user_email))
    render
  end

  it { should have_content("Hello #{user_login},") }
  it { should have_content('Your registration has been successful.') }
  it { should have_content("The email is sent to the following address: #{user_email}") }
  it { should have_field('Activation Code:') }
  it { should have_button('Activate my account') }
  it { should have_link('here') }
end
