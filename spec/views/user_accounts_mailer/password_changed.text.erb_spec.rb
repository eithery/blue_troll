require 'spec_helper'

describe "user_accounts_mailer/password_changed.text.erb" do
  subject { rendered }
  let(:user) { mock_user_account }

  before do
    assign(:user, user)
    render
  end

  it { should have_content("This email confirms that your password has been changed") }
  it { should have_content("https://bluetrolley2014.herokuapp.com/signin") }
  it { should have_content("please contact bluetrolley2014@gmail.com") }

  specify do
    user.should_receive(:name)
    render
  end
end
