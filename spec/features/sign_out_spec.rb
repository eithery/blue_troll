require 'spec_helper'

describe "Sign out operation" do
  let(:user) { FactoryGirl.create(:active_user) }

  subject { page }
  before { sign_in user }

  user { should_be_signed_in }
  it { should be_navigated_to user_profile(user) }

  context "always performs user sign out" do
    before { click_link 'Sign out' }

    user { should_be_signed_out }
    it { should be_navigated_to home_page }
  end
end
