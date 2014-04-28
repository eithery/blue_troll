require 'spec_helper'
include MailersHelper

describe ParticipantsMailer do
  let(:boss) { FactoryGirl.create(:fix) }
  let(:gwen) { FactoryGirl.create(:gwen, crew: boss.crew, email: 'gwen@gmail1.com') }
  let(:crew) { boss.crew }

  describe "#created" do
    let(:mail) { ParticipantsMailer.created(gwen, crew) }

    it "email should contains correct subject" do
      mail.subject.should == "#{sender}: #{participant_created_subject}"
    end

    it "sends email to newly registered participant" do
      mail.to.should include(gwen.email)
    end

    it "sends email to user who performed registration" do
      mail.to.should include(gwen.user_account.email)
    end

    it "sends email from Blue Trolley club" do
      mail.from.should include(club_email)
    end
  end


  describe "#approval_requested" do
    let(:mail) { ParticipantsMailer.approval_requested(gwen, crew) }

    it "email should contains correct subject" do
      mail.subject.should == "#{sender}: #{approval_request_subject}"
    end

    it "sends email to all group leads" do
      gwen.crew.leads.should have_at_least(1).user
      gwen.crew.leads.each do |lead|
        mail.to.should include(lead.email)
      end
    end

    it "sends email from Blue Trolley club" do
      mail.from.should include(club_email)
    end
  end


  describe "#approved" do
    let(:mail) { ParticipantsMailer.approved(gwen, crew) }

    it "email should contains correct subject" do
      mail.subject.should == "#{sender}: #{participant_approved_subject}"
    end

    it "sends email to newly registered participant" do
      mail.to.should include(gwen.email)
    end

    it "sends email to user who performed registration" do
      mail.to.should include(gwen.user_account.email)
    end

    it "sends email from Blue Trolley club" do
      mail.from.should include(club_email)
    end
  end
end
