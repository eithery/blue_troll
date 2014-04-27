require 'spec_helper'
include MailersHelper

describe ParticipantsMailer do
  let(:boss) { FactoryGirl.create(:fix) }
  let(:gwen) { FactoryGirl.create(:gwen, crew: boss.crew) }

  describe "#created" do
    let(:mail) { ParticipantsMailer.created(gwen) }

    it "email should contains correct subject" do
      mail.subject.should == "#{sender}: #{participant_created_subject}"
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
    let(:mail) { ParticipantsMailer.approved(gwen) }
  end
end
