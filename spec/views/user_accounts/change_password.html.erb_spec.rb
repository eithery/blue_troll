require 'spec_helper'

describe "user_accounts/change_password.html.erb" do
  subject { rendered }
  let(:user) { mock_user_account }
  before do
    assign(:user, user)
    render
  end

  it { should have_selector("form[action='#{change_password_path(id: user.id)}']") }
  it { should have_selector("legend", text: "Change your password") }
  it { should have_selector("input#user_account_email[readonly='readonly']") } 
  it { should have_selector("input[value='#{user.email}']") }

  it { should have_field("Email") }
  it { should have_field("Password", text: '') }
  it { should have_field("Password confirmation", text: '') }

  it { should have_button("Change password") }
  it { should have_link("Cancel", href: signin_path) }

  specify do
    user.should_receive(:email)
    render
  end
end
