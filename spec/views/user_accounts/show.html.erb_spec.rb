require 'spec_helper'

describe "user_accounts/show.html.erb" do
  subject { rendered }
  let(:user) { stub_model(UserAccount, login: 'johnsmith', email: 'jsmith@gmail.com') }
  let(:gwen) { stub_model(Participant, last_name: 'Protsenko', first_name: 'Gwen', age: 4, email: 'gwen@gmail.com') }
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


  describe "with no registered participants" do
    it { should_not have_selector('tbody tr') }
    it { should_not have_link('Click here')}
  end


  describe "with few registered participants" do
    before do
      user.should_receive(:participants).at_least(3).times.and_return(stub_participants)
      render
    end

    it { should have_selector('tbody tr', count: 3) }
    it { should have_selector('td', text: gwen.full_name) }
    it { should have_selector('td', text: gwen.email) }
    it { should have_selector('td', text: gwen.age) }
    it { should have_link("Click here to edit #{gwen.display_name}", href: edit_participant_path(gwen)) }
    it { should have_link("Click here to delete #{gwen.display_name}", href: participant_path(gwen)) }
    it { should have_link("Click here to download a ticket for #{gwen.display_name}",
      href: participant_ticket_path(participant_id: gwen.id)) }
  end


private
  def stub_participants
    [stub_model(Participant), gwen, stub_model(Participant)]
  end
end
