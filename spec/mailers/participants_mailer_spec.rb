require 'spec_helper'
include MailersHelper

describe ParticipantsMailer do
  let(:boss) { FactoryGirl.create(:fix) }
  let(:gwen) { FactoryGirl.create(:gwen, crew: boss.crew, email: 'gwen@gmail1.com') }

  subject { mail }

  describe "#created" do
    let(:mail) { ParticipantsMailer.created(gwen) }

    it { should have_subject("#{sender}: #{participant_created_subject}") }
    it { should be_sent_to gwen.email }

    it "sends email to user who performed registration" do
      should be_sent_to gwen.user_account.email
    end

    it { should be_sent_from club_email }
  end


  describe "#approval_requested" do
    let(:mail) { ParticipantsMailer.approval_requested(gwen) }

    it { should have_subject("#{sender}: #{approval_request_subject}") }

    it "sends email to all group leads" do
      gwen.crew.leads.should have_at_least(1).user
      gwen.crew.leads.each do |lead|
        should be_sent_to lead.email
      end
    end

    it { should be_sent_from club_email }
  end


  describe "#approved" do
    let(:mail) { ParticipantsMailer.approved(gwen) }

    it { should have_subject("#{sender}: #{participant_approved_subject}") }
    it { should be_sent_to gwen.email }

    it "sends email to user who performed registration" do
      mail.to.should include(gwen.user_account.email)
    end

    it { should be_sent_from club_email }
  end
end
