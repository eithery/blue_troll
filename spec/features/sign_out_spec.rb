require 'spec_helper'

describe "Sign out operation" do
  let(:user) { FactoryGirl.create(:active_user) }
  subject { page }

  before do
    sign_in user
  end

  it { should be_navigated_to user_profile(user) }
end
