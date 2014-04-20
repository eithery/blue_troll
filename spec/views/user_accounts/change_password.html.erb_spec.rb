require 'spec_helper'

describe "user_accounts/change_password.html.erb" do
  subject { rendered }
  before do
    assign(:user, mock_model(UserAccount))
    render
  end

  it { should have_selector("form[action='#{change_password_path}']") }
  it { should have_selector("legend", text: "Change your password") }
  it { should have_selector("input#user_account_email[readonly='readonly']") } 
  it { should have_field("Email") }
  it { should have_field("Password") }
  it { should have_field("Password confirmation") }

  it { should have_button("Change password") }
  it { should have_link("Cancel", href: signin_path) }
end
