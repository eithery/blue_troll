require 'spec_helper'

describe "Session pages" do
  subject { page }

  describe "sign in page" do
    before { visit signin_path }

    it { should have_title 'Blue Troll | Sign in' }
    it { should have_selector 'legend', text: 'Sign in' }
    it { should have_field 'Login or Email' }
    it { should have_field 'Password' }
    it { should have_button 'Sign in' }
    it { should have_link 'Register new', href: signup_path }

    it_behaves_like "Page with header"
    it_behaves_like "Page with footer"
  end
end
