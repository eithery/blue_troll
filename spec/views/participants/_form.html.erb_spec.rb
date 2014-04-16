require 'spec_helper'

shared_examples_for "participant form" do
  it { should have_selector("input[value='#{participant.user_account.id}'][type='hidden']") }
  it { should have_select('participant[crew_id]') }
  it { should have_selector('option', count: 4) }
  it { should have_selector("input[type='radio']", count: 3) }
  it { should have_selector("div.radio", text: 'Adult') }
  it { should have_selector("div.radio", text: 'Child (more than 6 years)') }
  it { should have_selector("div.radio", text: 'Child (0 - 6 years)') }
  it { should have_link('Cancel', href: user_account_path(user)) }
end


describe "participants/_form.html.erb" do
  subject { rendered }
  let(:crews) { [FactoryGirl.create(:crew), FactoryGirl.create(:spies), FactoryGirl.create(:fix_crew)] }
  let(:user) { stub_model(UserAccount) }
  let(:participant) { stub_model(Participant, user_account: user, crew: crews.second, last_name: 'Smith',
    first_name: 'Gwen', age_category: AgeCategory::BABY, age: 3, email: 'gwen@gmail1.com', cell_phone: '347-583-0140',
    address_line_1: '31 Gadsen Pl Staten Island NY 10314') }
  let(:new_participant) { stub_model(Participant, user_account: user).as_new_record }

  describe "for new participant" do
    before do
      crews
      assign(:participant, new_participant)
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
    before do
      assign(:participant, participant)
      render
    end

    it_behaves_like "participant form"

    it { should have_selector("form[action='#{participant_path(participant)}']") }
    it { should have_selector('legend', text: 'Edit Participant') }
    it { should have_selector("option[selected='selected']", count: 1, text: crews.second.name) }
    it { should have_selector("input#participant_last_name[value='#{participant.last_name}']") }
    it { should have_selector("input#participant_first_name[value='#{participant.first_name}']") }
    it { should have_selector("input[type='radio'][checked='checked'][value='2']") }
    it { should have_selector("input#participant_age[value='#{participant.age}']") }
    it { should have_selector("input#participant_email[value='#{participant.email}']") }
    it { should have_selector("input#participant_cell_phone[value='#{participant.cell_phone}']") }
    it { should have_selector("textarea#participant_address_line_1", text: participant.address_line_1) }
    it { should have_button('Update Participant') }
  end
end
