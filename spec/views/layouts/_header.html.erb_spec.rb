require 'spec_helper'

describe "layouts/_header.html.erb" do
  let(:user) { mock_user_account }
  subject { rendered }

  context "in any case" do
    before { render }

    it { should have_selector('header.navbar') }
    it { should have_link('Blue Trolley', href: root_path) }
    it { should have_selector('ul.nav', count: 2) }
  end


  context "where user is signed in" do
    before do
      sign_in(user)
      render
    end

    it { should_not have_link('Sign in') }
    it { should have_link('Sign out', href: signout_path) }
    it { should have_link('My Profile', href: user_account_path(user)) }
  end


  context "where user is not signed in" do
    before do
      sign_out
      render
    end

    it { should have_link('Sign in', href: signin_path) }
    it { should_not have_link('Sign out') }
    it { should_not have_link('My Profile') }
  end
end
