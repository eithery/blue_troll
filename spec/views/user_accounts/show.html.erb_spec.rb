require 'spec_helper'

describe "user_accounts/show.html.erb" do
  let(:crew) { mock_crew }
  let(:user) { mock_user_account(crew_id: crew.id) }
  let(:gwen) { stub_participant }

  subject { rendered }
  before do
    assign(:user, user)
    user.stub(:participants).and_return(stub_participants)
  end

  describe "in any case" do
    before { render }

    it { should have_content('Registered Participants') }
    it { should have_selector('table thead tr', count: 1) }
    it { should have_link('Change password', href: '#') }
  end


  describe "with no registered participants" do
    before do
      user.stub(:participants).and_return([])
      render
    end

    it { should_not have_link('Click here')}

    specify do
      gwen.should_not_receive(:display_name)
      render
    end

    specify do
      gwen.should_not_receive(:email)
      render
    end
  end


  context "with few registered participants" do
    before { render }
    it { should have_selector('tbody tr', minimum: 3) }
  end


  context "when crew is NOT selected" do
    before do
      user.stub(:crew).and_return(nil)
      render
    end

    it "'Register new participant' button should be disabled" do
      should have_selector("a[disabled='disabled']", text: 'Register new participant')
    end
  end


  context "when crew is selected" do
    before do
      user.stub(:crew).and_return(crew)
      render
    end

    it "enables 'Register new participant' button" do
      should have_link('Register new participant', href: new_participant_path(user_account_id: user.id))
      should_not have_selector("a[disabled='disabled']", text: 'Register new participant')
    end
  end


  context "when user does NOT have any approved participants" do
    before do
      gwen.stub(:approved?).and_return(false)
      render
    end

    it { should have_link('Select crew', href: '#') }
    it { should_not have_selector("a[disabled='disabled']", text: 'Select crew')}
  end


  context "wnen user has some participants approved by crew lead" do
    before do
      gwen.stub(:approved?).and_return(true)
      render
    end

    it { should have_selector("a[disabled='disabled']", text: 'Select crew')}
  end


  context "when payment is NOT confirmed" do
    before do
      gwen.stub(:payment_confirmed?).and_return(false)
      render
    end

    it { should have_selector("a[disabled='disabled'][href='#']", text: 'Download my tickets') }
  end


  context "when payment is confirmed by financier for some participant" do
    before do
      gwen.stub(:payment_confirmed?).and_return(true)
      render
    end

    it { should_not have_selector("a[disabled='disabled'][href='#']", text: 'Download my tickets') }
    it { should have_link('Download my tickets', href: '#') }
  end


private
  def stub_participants
    [stub_model(Participant), gwen, stub_model(Participant)]
  end
end
