require 'spec_helper'

describe "static_pages/home.html.erb" do
  subject { rendered }
  before { render }

  it { should have_content("Blue Trolley Event is coming") }
  it { should have_content("register to \"Blue Trolley\"") }
  it { should have_link('Register now!', href: signup_path) }
end
