require 'spec_helper'

describe "user_accounts_mailer/registered.text.erb" do
  subject { rendered }
  let(:activation_code) { '123456789' }
  let(:activation_token) { SecureRandom.uuid }
  let(:user) { mock_user_account activation_code: activation_code, activation_token: activation_token }

  before do
    assign(:user, user)
    render
  end

  it { should have_content('Thank you for registering in Blue Trolley club') }
  it { should have_content('Please click link below to activate your account.') }
  it { should have_content("#{club_url}/activate?activation_token=#{activation_token}") }
  it { should have_content("Your account activation code is: #{activation_code}") }

  specify do
    user.should_receive(:activation_code)
    render
  end

  specify do
    user.should_receive(:activation_token)
    render
  end
end
