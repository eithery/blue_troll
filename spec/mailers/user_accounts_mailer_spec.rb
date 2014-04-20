require "spec_helper"
include MailersHelper

shared_examples_for "user accounts mailer" do
  it "sent to user email address" do
    mail.to.should include(user.email)
  end

  it "duplicated to admin address" do
    mail.bcc.should include(admin_email)
  end

  it "sent from Blue Trolley club email address" do
    mail.from.should include(club_email)
  end
end


describe UserAccountsMailer do
  let(:user) { mock_model(UserAccount, email: 'gwen@gmail1.com').as_null_object }

  describe "#registered" do
    let(:mail) { UserAccountsMailer.registered(user) }
    specify { mail.subject.should == "#{sender}: #{registered_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#activated" do
    let(:mail) { UserAccountsMailer.activated(user) }
    specify { mail.subject.should == "#{sender}: #{activated_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_reset" do
    let(:mail) { UserAccountsMailer.password_reset(user) }
    specify { mail.subject.should == "#{sender}: #{password_reset_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_changed" do
    let(:mail) { UserAccountsMailer.password_changed(user) }
    specify { mail.subject.should == "#{sender}: #{password_changed_subject}" }
    it_behaves_like "user accounts mailer"
  end
end
