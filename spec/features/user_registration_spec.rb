require 'spec_helper'
include UserRegistrationHelper

describe "User account registration:" do
  let(:user) { FactoryGirl.build(:inactive_user) }
  subject { page }
  before { visit_registration_page }

  it_behaves_like "registration page"


  describe "when user is not registered yet" do
    describe "and enters and submit all valid information (happy path)" do
      before { fill_registration_form(user) }

      specify "new user account should be created" do
        expect { submit_registration_form }.to change{ UserAccount.count }.by(1)
      end


      describe "user is navigated to account activation page" do
        before { submit_registration_form }

        it_behaves_like "activation page"
        it { should have_content("Hello #{user.login}, welcome to Blue Trolley club!") }
        it { should have_content("Within few minutes, you will receive an email " +
          "with your activation link and activation code.") }
        it { should have_content("The email is sent to the following address: #{user.email}") }
        it { should have_content("In order to activate your account enter the code or " +
          "click on the link in your email.") }
        it { should have_selector('.alert-success', text: "New user account for #{user.login} has been created") }
      end


      describe "user receives email" do
        let(:mail) { UserAccountsMailer.deliveries.last }
        subject { mail }
        before do
          UserAccountsMailer.deliveries.clear
          submit_registration_form
        end

        specify { mail.to.should include(user.email) }
        specify { mail.subject.should == "Blue Trolley: club account activation" }

        describe "body" do
          subject { mail.body.encoded }
          it { should =~ /https:\/\/bluetrolley2014\./ }
          it { should =~ /Your account activation code is: [0-9]+/ }
        end
      end
    end
  end


  describe "when user is already registered" do
  end
end
