require 'spec_helper'

describe UserAccount do
  let(:user) { FactoryGirl.build(:inactive_user) }
  subject { user }

  it { should respond_to :login, :email, :email_confirmation, :password, :password_confirmation, :password_digest }
  it { should respond_to :crew_lead?, :financier?, :gatekeeper?, :admin?, :dev? }
  it { should respond_to :remember_token, :reset_password_token, :reset_password_expired_at }
  it { should respond_to :active?, :activation_token, :activation_code, :activated_at }
  it { should respond_to :created_at, :updated_at }
  it { should respond_to :name, :crew, :participants }
  it { should respond_to :authenticate }
  it { should respond_to :activate }
  it { should respond_to :generate_reset_token, :reset }

  it { should be_valid }

  it { should_not be_active }
  it { should_not be_crew_lead }
  it { should_not be_financier }
  it { should_not be_gatekeeper }
  it { should_not be_admin }
  it { should_not be_dev }


  describe "validation" do
    describe "when login" do
      context "is not entered" do
        before { user.login = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:login) }
      end

      context "is nil" do
        before { user.login = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:login) }
      end

      context "is too short" do
        before { user.login = 'a' }
        it { should_not be_valid }
        it { should have(1).error_on(:login) }
      end

      context "is duplicated" do
        before do
          existing_user = FactoryGirl.create(:active_user)
          user.login = existing_user.login.upcase
          user.save
        end
        it { should_not be_valid }
        it { should have(1).error_on(:login) }
      end
    end


    describe "when email" do
      context "is not entered" do
        before { user.email = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:email) }
      end

      context "confirmation is not entered" do
        before { user.email_confirmation = " " }
        it { should_not be_valid }
        it { should have(2).errors_on(:email_confirmation) }
      end

      context "does not match confirmation" do
        before { user.email_confirmation = 'mismatch@gmail.com' }
        it { should_not be_valid }
        it { should have(1).error_on(:email_confirmation) }
      end

      context "confirmation is nil" do
        before { user.email_confirmation = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:email_confirmation) }
      end

      context "format is invalid" do
        it "should be invalid" do
          emails = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo_bar+baz.com]
          emails.each do |invalid_email|
            user.email = user.email_confirmation = invalid_email
            user.should_not be_valid
            user.should have(1).error_on(:email)
          end
        end
      end

      context "format is valid" do
        it "should be valid" do
          emails = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
          emails.each do |valid_email|
            user.email = user.email_confirmation = valid_email
            user.should be_valid
            user.should_not have(:any).errors_on(:email)
          end
        end
      end

      context "is duplicated" do
        before do
          existing_user = FactoryGirl.create(:active_user)
          user.email = user.email_confirmation = existing_user.email.upcase
          user.save
        end
        it { should_not be_valid }
        it { user.should have(1).error_on(:email) }
      end

      describe "address with mixed case" do
        let(:mixed_case_email) { "Foo@ExAPMle.CoM" }

        it "should be saved as all lower case" do
          user.email = user.email_confirmation = mixed_case_email
          user.save
          user.reload.email.should == mixed_case_email.downcase
        end
      end
    end


    describe "when password" do
      context "is not entered" do
        before { user.password = user.password_confirmation = "  " }
        it { should_not be_valid }
        it { user.should have(2).errors_on(:password_confirmation) }
      end

      context "confirmation is not entered" do
        before { user.password_confirmation = "  " }
        it { should_not be_valid }
        it { user.should have(2).errors_on(:password_confirmation) }
      end

      context "does not match confirmation" do
        before { user.password_confirmation = 'mismatch'}
        it { should_not be_valid }
        it { user.should have(1).error_on(:password_confirmation) }
      end

      context "confirmation is nil" do
        before { user.password_confirmation = nil }
        it { should_not be_valid }
        it { user.should have(1).error_on(:password_confirmation) }
      end

      context "is too short" do
        before { user.password = user.password_confirmation = "a" * 5 }
        it { should_not be_valid }
        it { user.should have(1).error_on(:password) }
      end
    end
  end



  describe "authenticate method return value" do
    before { user.save }
    let(:found_user_account) { UserAccount.find_by_email(user.email) }

    context "with valid password" do
      it { should == found_user_account.authenticate(user.password) }
    end

    context "with invalid password" do
      let(:user_account_for_invalid_password) { found_user_account.authenticate('invalid') }
      it { should_not == user_account_for_invalid_password }
      specify { user_account_for_invalid_password.should be_false }
    end
  end


  describe "name" do
    specify { user.name.should == user.login }
  end
end
