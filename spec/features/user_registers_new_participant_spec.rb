require 'spec_helper'

describe "User creates new participant" do
  let(:user) { FactoryGirl.create(:active_user) }

  subject { page }
  before do
    prepare_test_data
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
    end

    specify { expect { submit_new_participant }.to change { Participant.count }.by(1) }

    context "and user submits form" do
      before { submit_new_participant }

      it { should be_navigated_to user_profile(user) }
      it { should have_content('Hvostan, Gwen') }
      it { should display_message('Gwen Hvostan has been successfully registered') }
    end

    context "emails send to all crew leads related to the new participant registration" do
      specify { expect_to_send_email(ParticipantsMailer, to: @boss.email,
        subject: "#{sender}: #{participant_created_subject}") { submit_new_participant } }

      specify do
        email_should_contain(ParticipantsMailer, [
          /Уважаемый кондуктор!/, /Gwen Hvostan/, /принимается в вашу группу/]) { submit_new_participant }
      end
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

  def prepare_test_data
    crew = FactoryGirl.create(:crew)
    FactoryGirl.create(:spies)
    FactoryGirl.create(:fix_crew)
    @boss = FactoryGirl.create(:fix, crew: crew)
  end
end
