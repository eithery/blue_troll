require 'spec_helper'

describe "user_accounts/show.html.erb" do
  subject { rendered }
  let(:user) { mock_user_account }
  let(:gwen) { stub_participant }
  before do
    assign(:user, user)
    render
  end

  it { should have_selector('img.gravatar') }
  it { should have_content(user.login) }
  it { should have_content(user.email) }
  it { should have_content('Status:') }
  it { should have_link('Change password', href: '#') }
  it { should have_content('Registered Participants') }
  it { should have_selector('table thead tr', count: 1) }

  it { should have_link('Register new participant',
    href: new_participant_path(user_account_id: user.id, crew_id: user.crew)) }
  it { should have_selector("a[disabled='disabled'][href='#']", text: 'Download my tickets') }

  it { should have_selector("div.modal-dialog")}

#  it { should have_select('participant[crew_id]') }
#  it { should have_selector('option', count: 4) }
#  it { should have_selector("option[selected='selected']", count: 1, text: crews.last.name) }

  specify do
    user.should_receive(:login)
    render
  end

  specify do
    user.should_receive(:email)
    render
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


  describe "with few registered participants" do
    before do
      user.stub(:participants).and_return(stub_participants)
      render
    end

    it { should have_selector('tbody tr', minimum: 3) }
    it { should have_selector('td', text: gwen.full_name) }
    it { should have_selector('td', text: gwen.email) }
    it { should have_selector('td', text: gwen.age) }

    it { should have_link("Click here to edit #{gwen.display_name}", href: edit_participant_path(gwen)) }
    it { should have_link("Click here to delete #{gwen.display_name}", href: participant_path(gwen)) }
    it { should have_link("Click here to download a ticket for #{gwen.display_name}",
      href: participant_ticket_path(participant_id: gwen.id)) }

    specify do
      gwen.should_receive(:display_name).at_least(4).times
      render
    end

    specify do
      gwen.should_receive(:email).twice
      render
    end
  end


private
  def stub_participants
    [stub_model(Participant), gwen, stub_model(Participant)]
  end
end
