require 'spec_helper'

describe "layouts/_header.html.erb" do
  include SessionsHelper
  subject { rendered }
  let(:user) { stub_model(UserAccount) }
  before { render }

  it { should have_selector('header.navbar') }
  it { should have_link('Blue Trolley', href: root_path) }
  it { should have_selector('ul.nav', count: 2) }


  context "where user is signed in" do
    before do
      sign_in(user)
      render
    end

    it { should have_link('Sign out', href: signout_path) }
    it { should have_link('My Profile', href: user_account_path(user)) }
  end


  context "where user is not signed in" do
    it { should have_link('Sign in', href: signin_path) }
  end
end
