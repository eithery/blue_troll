require 'spec_helper'

describe "user_accounts/_crew_selector.html.erb" do
  let(:crew) { mock_crew }
  let(:all_crews) { mock_crews }
  let(:user) { mock_user_account crew_id: crew.id }

  subject { rendered }
  before do
    Crew.stub(:order).and_return(all_crews)
    assign(:user, user)
    render
  end

  it { should have_selector("div.modal-dialog") }
  it { should have_content("Please select your Blue Trolley crew") }
  it { should have_selector("form[action='#{select_crew_path}']") }
  it { should have_select('user[crew_id]') }
  it { should have_selector('option', count: 4) }
  it { should have_selector("option[selected='selected']", count: 1, text: all_crews.last.name) }
  it { should have_button('Select crew') }

  specify do
    user.should_receive(:crew_id).and_return(crew.id)
    render
  end
end
