require 'spec_helper'
include UserRegistrationSpecHelper

describe "New user account registration" do
  let(:user) { FactoryGirl.build(:inactive_user) }

  subject { page }
  before { visit_registration_page }

  it_behaves_like "registration page"

  describe "when user is not registered yet" do
    describe "and enters all valid information (happy path)" do
      before { fill_registration_form(user) }

      it_behaves_like "new user account is created"

      describe "and submits registration form" do
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


      describe "user receives email by submit registration form" do
        specify { expect_to_send_email(UserAccountsMailer, to: user.email,
          subject: "#{sender}: #{registered_subject}") { submit_registration_form } }

        specify do
          email_should_contain(UserAccountsMailer,
            [/https:\/\/bluetrolley2014\.herokuapp\.com\/activate\?/, /Your account activation code is: [0-9]+/]) {
              submit_registration_form
            }
        end
      end
    end
  end


  describe "when user is already registered" do
    let(:existing_user) { FactoryGirl.create(:active_user) }

    context "and user login already exists in DB" do
      before do
        user.login = existing_user.login.upcase
        fill_registration_form(user)
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        it_behaves_like "registration page"

        specify { user.should have(1).error_on(:login) }
        it { should have_content('Login has already been taken') }
      end
    end


    context "and user email already exists in DB" do
      before do
        user.email = user.email_confirmation = existing_user.email.upcase
        fill_registration_form(user)
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        specify { user.should have(1).error_on(:email) }
        it { should have_content('Email has already been taken') }
      end
    end
  end
end
