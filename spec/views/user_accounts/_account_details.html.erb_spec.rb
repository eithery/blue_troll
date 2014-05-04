require 'spec_helper'

describe "user_accounts/_account_details.html.erb" do
  let(:crew) { stub_crew }
  let(:user) { mock_user_account }

  subject { rendered }
  before do
    assign(:user, user)
    render
  end

  it { should have_selector('img.gravatar') }
  it { should have_content('Login:') }
  it { should have_content('Email:') }
  it { should have_content('Status:') }
  it { should have_content('Crew:') }

  it { should have_content(user.login) }
  it { should have_content(user.email) }

  specify do
    user.should_receive(:login)
    render
  end

  specify do
    user.should_receive(:email)
    render
  end

  specify do
    user.should_receive(:crew)
    render
  end


  describe "when crew is NOT selected" do
    before do
      user.stub(:crew).and_return(nil)
      render
    end

    it { should have_selector('td.no-crew-selected', text: 'Please select the crew.') }
  end


  describe "when crew is selected" do
    before do
      crew.stub(:to_s).and_return(crew.display_name)
      user.stub(:crew).and_return(crew)
      render
    end

    it { should_not have_selector('td', text: 'Crew is not selected') }
    it { should have_content(user.crew.display_name) }
  end
end
