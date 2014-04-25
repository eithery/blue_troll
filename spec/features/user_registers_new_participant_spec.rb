require 'spec_helper'

describe "User creates new participant" do
  let(:user) { FactoryGirl.create(:active_user) }

  subject { page }
  before do
    sign_in user
    click_link 'Register new participant'
  end

  user { should_be_signed_in }
end
