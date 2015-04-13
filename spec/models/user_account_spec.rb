require 'spec_helper'

describe UserAccount do
  let(:user) { FactoryGirl.build(:inactive_user) }
  let(:empty_user_account) { FactoryGirl.create(:active_user) }
  let(:gwen) { FactoryGirl.create(:gwen) }
  let(:maryika) { FactoryGirl.create(:maryika, user_account: gwen.user_account) }
  let(:gaby) { FactoryGirl.create(:gaby, user_account: gwen.user_account) }
  let(:new_user) { UserAccount.new(login: 'gwen123', email: 'hvost1@gmail.com', email_confirmation: 'hvost1@gmail.com',
    password: 'secret', password_confirmation: 'secret') }

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
    context "when login" do
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


    context "when email" do
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


    context "when password" do
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


  describe "#authenticate" do
    before { user.save }
    let(:found_user_account) { UserAccount.find_by_email(user.email) }

    context "with valid password" do
      it { should == found_user_account.authenticate(user.password) }
    end

    context "with invalid password" do
      let(:user_account_for_invalid_password) { found_user_account.authenticate('invalid') }
      it { should_not == user_account_for_invalid_password }
      specify { user_account_for_invalid_password.should be false }
    end
  end


  describe "#name" do
    specify { user.name.should == user.login }
  end


  describe "#participants" do
    subject { gwen.user_account }
    before { gwen; maryika; gaby; }

    it { should have(3).participants }
    its(:participants) { should include(gwen, maryika, gaby) }
    specify { empty_user_account.should_not have(:any).participants }
  end


  describe "#crew" do
    it "blank for the newly created user" do
      user = new_user
      user.save
      user.reload.crew.should be_blank
    end

    it "equals to the crew this user belongs to" do
      fix_crew = FactoryGirl.create(:fix_crew)
      fix = FactoryGirl.create(:active_user, crew: fix_crew)
      fix.crew.should be_equal(fix_crew)
    end
  end


  describe "#remember_token" do
    it "generated by save user account" do
      user = new_user
      user.remember_token.should be_blank
      user.save
      user.remember_token.should_not be_blank
      user.reload.remember_token.should_not be_blank
    end

    it "different from previous one after save operations" do
      token_before = gwen.user_account.remember_token
      token_before.should_not be_blank
      gwen.user_account.save
      gwen.user_account.remember_token.should_not == token_before
    end
  end


  describe "#activate" do
    context "wnen provided activation code or token is invalid" do
      let(:invalid_code_or_token) { '123456789' }
      before { user.activate(invalid_code_or_token) }

      it { should_not be_active }
      its(:activated_at) { should be_nil }
    end

    context "by valid code" do
      before { user.activate(user.activation_code) }
      it { should be_active }
      its(:activated_at) { should_not be_nil }
    end

    context "by valid activation token" do
      before { user.activate(user.activation_token) }
      it { should be_active }
      its(:activated_at) { should_not be_nil }
    end
  end


  describe "#activation_token" do
    subject { new_user.activation_token }

    context "for new user account" do
      it { should be_blank }
    end

    context "for saved user account" do
      before { new_user.save }
      it { should_not be_blank }
    end
  end


  describe "#activation_code" do
    subject { new_user.activation_code }

    context "for new user account" do
      it { should be_blank }
    end

    context "for saved user account" do
      before { new_user.save }

      it { should_not be_blank }
      it { should have_at_least(6).digits }
    end
  end


  describe "#generate_reset_token" do
    subject { gwen.user_account }
    before { gwen.user_account.generate_reset_token }

    its(:reset_password_token) { should_not be_blank }
    its(:reset_password_expired_at) { should_not be_blank }
  end


  describe "#reset" do
    subject { gwen.user_account }
    before do
      gwen.user_account.generate_reset_token
      gwen.user_account.reset
    end

    its(:reset_password_token) { should be_nil }
    its(:reset_password_expired_at) { should be_nil }
  end
end
