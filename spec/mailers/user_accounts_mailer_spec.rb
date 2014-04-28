require "spec_helper"
include MailersHelper

shared_examples_for "user accounts mailer" do
  it { should be_sent_to user.email }
  it { should be_sent_from club_email }
end


describe UserAccountsMailer do
  let(:user) { mock_user_account email: 'gwen@gmail1.com' }
  subject { mail }

  describe "#registered" do
    let(:mail) { UserAccountsMailer.registered(user) }
    it { should have_subject "#{sender}: #{registered_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#activated" do
    let(:mail) { UserAccountsMailer.activated(user) }
    it { should have_subject "#{sender}: #{activated_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_reset" do
    let(:mail) { UserAccountsMailer.password_reset(user) }
    it { should have_subject "#{sender}: #{password_reset_subject}" }
    it_behaves_like "user accounts mailer"
  end


  describe "#password_changed" do
    let(:mail) { UserAccountsMailer.password_changed(user) }
    it { should have_subject "#{sender}: #{password_changed_subject}" }
    it_behaves_like "user accounts mailer"
  end
end
