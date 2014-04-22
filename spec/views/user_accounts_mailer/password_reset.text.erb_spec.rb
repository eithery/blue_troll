require 'spec_helper'

describe "user_accounts_mailer/password_reset.text.erb" do
  subject { rendered }
  let(:reset_token) { SecureRandom.uuid }
  let(:user) { mock_user_account reset_password_token: reset_token }

  before do
    assign(:user, user)
    render
  end

  it { should have_content("We received a request to reset the password associated with this email address") }
  it { should have_content("Click the link below to reset your password") }
  it { should have_content("#{club_url}/pwd_reset?reset_token=#{reset_token}")}

  specify do
    user.should_receive(:name)
    render
  end

  specify do
    user.should_receive(:reset_password_token)
    render
  end
end
