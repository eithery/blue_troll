require 'spec_helper'

describe UserAccount do
  before { @user_account = UserAccount.new(login: 'jsmith', email: 'jsmith@gmail.com', email_confirmation: 'jsmith@gmail.com',
    password: 'secret', password_confirmation: 'secret') }
  subject { @user_account }

  it { should respond_to :login }
  it { should respond_to :email }
  it { should respond_to :email_confirmation }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :active? }
  it { should respond_to :activated_at }
  it { should respond_to :authenticate }
  it { should respond_to :participants }
  it { should be_valid }
  it { should_not be_active }


  describe "when login" do
    context "is not entered" do
      before { @user_account.login = "  " }
      it { should_not be_valid }
    end

    context "is too short" do
      before { @user_account.login = "a" * 5 }
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
      before { @user_account.email_confirmation = 'mismatch' }
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
  end


  describe "when password" do
    context "is not present" do
      before { @user_account.password = @user_account.password_confirmation = "  " }
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


  describe "return value of authenticate method" do
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
end