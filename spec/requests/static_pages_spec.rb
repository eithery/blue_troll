require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_title 'Blue Troll | Home' }
    it { should have_content 'Blue Trolley Event is coming soon' }
    it { should have_link 'Register now!', href: signup_path }

    it_behaves_like "Page with header"
    it_behaves_like "Page with footer"
  end
end
