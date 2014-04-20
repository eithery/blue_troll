require 'spec_helper'

describe "user_accounts_mailer/activated.text.erb" do
  subject { rendered }
  before { render }

  it { should have_content("Your account has now been activated") }
  it { should have_content("https://bluetrolley2014.herokuapp.com/signin") }
  it { should have_content("Upon logging in you will be able") }
end
