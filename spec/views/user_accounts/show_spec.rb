require 'spec_helper'

describe "user_accounts/show.html.erb" do
  subject { rendered }
  let(:user) { FactoryGirl.create(:active_user)}
  before do
    assign(:user, user)
    render
  end

  it { should have_selector('table') }
  it { should have_link 'Create new participant' }
end
