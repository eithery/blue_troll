require 'spec_helper'

describe "user_accounts/request_to_activate.html.erb" do
  before { render }
  subject { rendered }

  it { should =~ /Hello/ }
  it { should =~ /Your registration has been successful./ }
  it { should =~ /The email is sent to the following address/ }
end
