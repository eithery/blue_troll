require 'spec_helper'

describe "New user account registration" do
  let(:user) { FactoryGirl.build(:inactive_user) }

  shared_examples_for "new user account is created" do
    specify { expect { submit_registration_form }.to change{ UserAccount.count }.by(1) }
  end

  shared_examples_for "new user account is not created" do
    specify { expect { submit_registration_form }.not_to change{ UserAccount.count } }
  end

  subject { page }
  before do
    visit root_path
    click_link 'Register now!'
  end

  it { should be_navigated_to new_user_account_page }

  describe "when user is not registered yet and enters all valid info" do
    before { fill_registration_form }

    it_behaves_like "new user account is created"

    context "and submits registration form" do
      before { submit_registration_form }

      it { should be_navigated_to activation_page(user) }
      it { should display_message "New user account for #{user.login} has been created" }
    end

    context "user receives email by submit registration form" do
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


  describe "when user is already registered" do
    let(:existing_user) { FactoryGirl.create(:active_user) }

    context "and user login already exists in DB" do
      before do
        user.login = existing_user.login.upcase
        fill_registration_form
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        it { should be_navigated_to new_user_account_page }
        specify { user.should have(1).error_on(:login) }
        it { should have_content('Login has already been taken') }
      end
    end


    context "and user email already exists in DB" do
      before do
        user.email = user.email_confirmation = existing_user.email.upcase
        fill_registration_form
      end

      it_behaves_like "new user account is not created"

      context "after submitting registration form" do
        before { submit_registration_form }

        specify { user.should have(1).error_on(:email) }
        it { should have_content('Email has already been taken') }
      end
    end
  end


private
  def fill_registration_form
    fill_in 'Login', with: user.login
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    fill_in 'Email', with: user.email
    fill_in 'Email Confirmation', with: user.email
  end

  def submit_registration_form
    click_button 'Create my account'
  end
end
