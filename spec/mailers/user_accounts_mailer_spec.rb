# Eithery Lab, 2016.
# UserAccounts mailer specs.

require 'rails_helper'

shared_examples_for 'user accounts mailer' do
  it { expect(mail).to be_sent_to user.email }
  it { expect(mail).to be_sent_from UserAccountsMailer::CLUB_EMAIL }
  it { expect { mail.deliver_now }.to change { UserAccountsMailer.deliveries.count }.by 1 }
end


describe UserAccountsMailer do
  include MailerMatchers

  let(:user) { FactoryGirl.build :user_account, email: 'gwen@gmail.com' }

  it { should respond_to :account_activation }

  describe '#account_activation' do
    let(:mail) { UserAccountsMailer.account_activation user }

    it_behaves_like 'user accounts mailer'
    it { expect(mail).to have_subject 'Blue Trolley: Account activation' }
  end
end

=begin
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
=end
