require 'spec_helper'

shared_examples_for "participant form" do
  it { should have_selector("input[value='#{participant.user_account_id}'][type='hidden']") }
  it { should have_selector("input[type='radio']", count: 3) }
  it { should have_selector("div.radio", text: 'Adult') }
  it { should have_selector("div.radio", text: 'Child (3 - 16 years)') }
  it { should have_selector("div.radio", text: 'Child (under 3 years)') }
  it { should have_link('Cancel', href: user_account_path(participant.user_account)) }
end


describe "participants/_form.html.erb" do
  let(:crews) { mock_crews }
  let(:user) { mock_user_account }

  subject { rendered }
  before { Crew.stub(:order).and_return(crews) }

  describe "for new participant" do
    let(:participant) { stub_new_participant }
    before do
      crews
      assign(:participant, participant)
      render
    end

    it_behaves_like "participant form"

    it { should have_selector("form[action='#{participants_path}']") }
    it { should have_selector('legend', text: 'New Participant') }
    it { should_not have_selector("option[selected='selected']") }
    it { should have_field('Last name') }
    it { should have_field('First name') }
    it { should have_selector("input[type='radio'][checked='checked'][value='0']") }
    it { should have_field('Age') }
    it { should have_field('Email') }
    it { should have_field('Phone') }
    it { should have_field('Address') }
    it { should have_button('Create Participant') }
  end


  describe "for existing participant" do
    let(:participant) { stub_participant user_account: user, crew_id: crews.last.id }

    before do
      assign(:participant, participant)
      render
    end

    it_behaves_like "participant form"

    it { should have_selector("form[action='#{participant_path(participant)}']") }
    it { should have_selector('legend', text: 'Edit Participant') }
    it { should have_selector("input#participant_last_name[value='#{participant.last_name}']") }
    it { should have_selector("input#participant_first_name[value='#{participant.first_name}']") }
    it { should have_selector("input[type='radio'][checked='checked'][value='2']") }
    it { should have_selector("input#participant_age[value='#{participant.age}']") }
    it { should have_selector("input#participant_email[value='#{participant.email}']") }
    it { should have_selector("input#participant_cell_phone[value='#{participant.cell_phone}']") }
    it { should have_selector("textarea#participant_address", text: participant.address) }
    it { should have_button('Update Participant') }
  end
end
