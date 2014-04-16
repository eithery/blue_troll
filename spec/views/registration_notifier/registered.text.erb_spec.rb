require 'spec_helper'

describe "registration_notifier/registered.text.erb" do
  subject { rendered }
  let(:activation_code) { '123456789' }
  let(:user) { stub_model(UserAccount, activation_code: activation_code) }
  before do
    assign(:user, user)
    render
  end

  it { should have_content('Thank you for registering in Blue Trolley club') }
  it { should have_content('Please click link below to activate your account.') }
  it { should have_content("https://bluetrolley2014.heroku.com/activation?activation_id=#{activation_code}") }
  it { should have_content("Your account activation code is: #{activation_code}") }

  specify do
    user.should_receive(:activation_code).twice
    render
  end
end
