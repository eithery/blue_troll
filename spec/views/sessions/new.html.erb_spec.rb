require 'spec_helper'

describe "sessions/new.html.erb" do
  subject { rendered }
  before { render }

  it { should have_selector("form[action='#{sessions_path}']") }
  it { should have_selector('legend', text: 'Sign in') }
  it { should have_field('Login or Email') }
  it { should have_field('Password') }
  it { should have_button('Sign in') }
  it { should have_link('Register new', href: signup_path) }
end
