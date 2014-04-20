require 'spec_helper'

describe "user_accounts_mailer/password_changed.text.erb" do
  subject { rendered }
  let(:user) { mock_model(UserAccount, name: 'gwen') }
  before do
    assign(:user, user)
    render
  end

  it { should have_content("This email confirms that your password has been changed") }

  specify do
    user.should_receive(:name)
    render
  end
end
