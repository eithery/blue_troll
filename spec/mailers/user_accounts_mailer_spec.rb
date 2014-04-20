require "spec_helper"

shared_examples_for "user accounts mailer" do
  it "sent to user email address" do
    mail.to.should include(user.email)
  end

  it "duplicated to admin address" do
    mail.bcc.should include('michael.protsenko@gmail.com')
  end

  it "sent from Blue Trolley club email address" do
    mail.from.should include('bluetrolley2014@gmail.com')      
  end
end


describe UserAccountsMailer do
  let(:user) { mock_model(UserAccount, email: 'gwen@gmail1.com').as_null_object }

  describe "#registered" do
    let(:mail) { UserAccountsMailer.registered(user) }
    specify { mail.subject.should == "Blue Trolley: club account activation" }
    it_behaves_like "user accounts mailer"
  end


  describe "#activated" do
    let(:mail) { UserAccountsMailer.activated(user) }
    specify { mail.subject.should == "Blue Trolley: account has been activated" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_reset" do
    let(:mail) { UserAccountsMailer.password_reset(user) }
    specify { mail.subject.should == "Blue Trolley: password reset" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_changed" do
    let(:mail) { UserAccountsMailer.password_changed(user) }
    specify { mail.subject.should == "Blue Trolley: password has been changed" }
    it_behaves_like "user accounts mailer"
  end
end
