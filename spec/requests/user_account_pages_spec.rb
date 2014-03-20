require 'spec_helper'

describe "User account pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_title 'Blue Troll | New User Account' }
    it { should have_selector 'legend', text: 'New User Account Registration' }
    it { should have_field 'Login' }
    it { should have_field 'Password' }
    it { should have_field 'Password Confirmation' }
    it { should have_field 'Email' }
    it { should have_field 'Email Confirmation' }
    it { should have_button 'Create my account' }

    it_behaves_like "Page with header"
    it_behaves_like "Page with footer"
  end
end
