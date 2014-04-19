require 'spec_helper'

describe "password_reset/new.html.erb" do
  subject { rendered }
  before { render }

  it { should have_selector("form[action='#{reset_password_path}']") }
  it { should have_selector("legend", text: "Can't access your account?") }
  it { should have_content("If you can't access Blue Troll application, please enter your login or email") }
  it { should have_field("Enter your login or email") }

  it { should have_button('Send email') }
  it { should have_link('Cancel', href: signin_path) }
end
