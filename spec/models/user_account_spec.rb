require 'spec_helper'

describe UserAccount do
  before { @user_account = UserAccount.new(login: 'jsmith', email: 'jsmith@gmail.com',
    email_confirmation: 'jsmith@gmail.com', password: 'secret', password_confirmation: 'secret') }
  subject { @user_account }

  it { should respond_to :login }
  it { should respond_to :email }
  it { should respond_to :email_confirmation }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }
  it { should respond_to :remember_token }
  it { should respond_to :crew_lead? }
  it { should respond_to :financier? }
  it { should respond_to :gatekeeper? }
  it { should respond_to :admin? }
  it { should respond_to :dev? }
  it { should respond_to :active? }
  it { should respond_to :activation_code }
  it { should respond_to :activated_at }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }

  it { should respond_to :name }
  it { should respond_to :authenticate }
  it { should respond_to :participants }

  it { should be_valid }

  it { should_not be_active }
  it { should_not be_crew_lead }
  it { should_not be_financier }
  it { should_not be_gatekeeper }
  it { should_not be_admin }
  it { should_not be_dev }


  describe "when login" do
    context "is not entered" do
      before { @user_account.login = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { @user_account.login = nil }
      it { should_not be_valid }
    end

    context "is too short" do
      before { @user_account.login = 'a' }
      it { should_not be_valid }
    end

    context "is duplicated" do
      before do
        existing_user_account = @user_account.dup
        existing_user_account.login = @user_account.login.upcase
        existing_user_account.save
      end
      it { should_not be_valid }
    end
  end


  describe "when email" do
    context "is not entered" do
      before { @user_account.email = "  " }
      it { should_not be_valid }
    end

    context "confirmation is not entered" do
      before { @user_account.email_confirmation = " " }
      it { should_not be_valid }
    end

    context "does not match confirmation" do
      before { @user_account.email_confirmation = 'mismatch@gmail.com' }
      it { should_not be_valid }
    end

    context "confirmation is nil" do
      before { @user_account.email_confirmation = nil }
      it { should_not be_valid }
    end

    context "format is invalid" do
      it "should be invalid" do
        emails = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo_bar+baz.com]
        emails.each do |invalid_email|
          @user_account.email = @user_account.email_confirmation = invalid_email
          @user_account.should_not be_valid
        end
      end
    end

    context "format is valid" do
      it "should be valid" do
        emails = %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
        emails.each do |valid_email|
          @user_account.email = @user_account.email_confirmation = valid_email
          @user_account.should be_valid
        end
      end
    end

    context "is duplicated" do
      before do
        existing_user_account = @user_account.dup
        existing_user_account.email = existing_user_account.email_confirmation = @user_account.email.upcase
        existing_user_account.save
      end
      it { should_not be_valid }
    end

    describe "address with mixed case" do
      let(:mixed_case_email) { "Foo@ExAPMle.CoM" }
      it "should be saved as all lower case" do
        @user_account.email = @user_account.email_confirmation = mixed_case_email
        @user_account.save
        @user_account.reload.email.should == mixed_case_email.downcase
      end
    end
  end


  describe "when password" do
    context "is not entered" do
      before { @user_account.password = @user_account.password_confirmation = "  " }
      it { should_not be_valid }
    end

    context "confirmation is not entered" do
      before { @user_account.password_confirmation = "  " }
      it { should_not be_valid }
    end

    context "does not match confirmation" do
      before { @user_account.password_confirmation = 'mismatch'}
      it { should_not be_valid }
    end

    context "confirmation is nil" do
      before { @user_account.password_confirmation = nil }
      it { should_not be_valid }
    end

    context "is too short" do
      before { @user_account.password = @user_account.password_confirmation = "a" * 5 }
      it { should_not be_valid }
    end
  end


  describe "authenticate method return value" do
    before { @user_account.save }
    let(:found_user_account) { UserAccount.find_by_email(@user_account.email) }

    context "with valid password" do
      it { should == found_user_account.authenticate(@user_account.password) }
    end

    context "with invalid password" do
      let(:user_account_for_invalid_password) { found_user_account.authenticate('invalid') }
      it { should_not == user_account_for_invalid_password }
      specify { user_account_for_invalid_password.should be_false }
    end
  end


  describe "name" do
    specify { @user_account.name.should == @user_account.login }
  end
end
