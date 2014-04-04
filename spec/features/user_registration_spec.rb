require 'spec_helper'

describe "User account registration:" do
  let(:user_account) { FactoryGirl.build(:user_account) }
  let(:create_account) { 'Create my account' }
  subject { page }
  before do
    visit root_path
    click_link 'Register now!'
  end


  describe "user is navigated to new user account page" do
    it { should have_title('New User Account') }
  end


  describe "when user is not registered yet" do
    describe "and enters and submit all valid information (happy path)" do
      before do
        fill_in 'Login', with: user_account.login
        fill_in 'Password', with: user_account.password
        fill_in 'Password Confirmation', with: user_account.password
        fill_in 'Email', with: user_account.email
        fill_in 'Email Confirmation', with: user_account.email
      end


      specify "new user account should be created" do
        expect { click_button create_account }.to change{ UserAccount.count }.by(1)
      end


      describe "user is navigated to account activation page" do
        before { click_button create_account }

        it { should have_title('Account Activation') }
        it { should have_content("Hello #{user_account.login}, Welcome to Blue Trolley club!") }
        it { should have_content("Within few minutes, you will receive an email " +
          "with your activation link and activation code.") }
        it { should have_content("The email is sent to the following address: #{user_account.email}") }
        it { should have_content("In order to activate your account enter the code or " +
          "click on the link in your email.") }
        it { should have_selector('.alert-success', text: "New user account for #{user_account.login} is created.") }
      end


      describe "user receives email" do
        let(:mail) { RegistrationNotifier.deliveries.first }
        subject { mail }
        before { click_button create_account }

        specify { mail.to.should include(user_account.email) }
        specify { mail.subject.should == "Blue Trolley club account activation" }

        describe "body" do
          subject { mail.body.encoded }
          it { should =~ /https:\/\/bluetrolley2014\./ }
          it { should =~ /Your account activation code is: [0-9]{10}/ }
        end
      end
    end
  end


  describe "when user is already registered" do
  end
end
