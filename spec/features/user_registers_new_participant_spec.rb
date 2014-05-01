require 'spec_helper'

describe "User creates new participant" do
  let(:user) { FactoryGirl.create(:gwen_account) }


#  let(:gwen_email) { 'gwen123@gmail1.com' }
#    crew = FactoryGirl.create(:crew)
#    FactoryGirl.create(:spies)
#    FactoryGirl.create(:fix_crew)
#    fix_account = FactoryGirl.create(:crew_lead, crew: crew)
#    @boss = FactoryGirl.create(:fix, user_account: fix_account)

  subject { page }
  before do
    sign_in user
    click_link 'Register new participant'
  end

  user { should_be_signed_in }
  it { should be_navigated_to new_participant_page }


  context "when user enters valid info" do
    before do
      select 'Guests'
      fill_in 'Last name', with: 'Hvostan'
      fill_in 'First name', with: 'Gwen'
      fill_in 'Email', with: gwen_email
    end

    specify { expect { submit_new_participant }.to change { Participant.count }.by(1) }

    context "and user submits form" do
      before { submit_new_participant }

      it { should be_navigated_to user_profile(user) }
      it { should have_content('Hvostan, Gwen') }
      it { should display_message('Gwen Hvostan has been successfully registered') }
    end

    context "emails send to all crew leads related to the new participant registration" do
      specify { ->{ submit_new_participant }.should send_email(ParticipantsMailer, to: user.email,
        subject: "#{sender}: #{participant_created_subject}") }
      specify { ->{ submit_new_participant }.should send_email(ParticipantsMailer, to: gwen_email,
        subject: "#{sender}: #{participant_created_subject}") }
      specify { ->{ submit_new_participant }.should send_email(ParticipantsMailer, to: @boss.email,
        subject: "#{sender}: #{approval_request_subject}") }
    end
  end


  context "when entered information is not valid" do
    specify { expect { submit_new_participant }.not_to change { Participant.count } }

    context "and user submits form" do
      before { submit_new_participant }

      it { should be_navigated_to new_participant_page }
      it { should have_content("from being saved") }
      it { should have_selector('.panel-body ul li', minimum: 3) }
    end
  end


private
  def submit_new_participant
    click_button 'Create Participant' 
  end
end
