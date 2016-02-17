# Eithery Lab, 2016.
# UserAccount model specs.

require 'rails_helper'

describe UserAccount do
  subject(:user) { FactoryGirl.build :user_account }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :login, :email, :email_confirmation }
  it { should respond_to :password, :password_confirmation, :password_digest }
  it { should respond_to :admin? }
  it { should respond_to :activation_digest, :activated?, :activated_at }
  it { should respond_to :reset_digest, :reset_sent_at }
  it { should respond_to :crew, :participants }
  it { should respond_to :name, :to_file_name }
  it { should respond_to :authenticate, :authenticated? }
  it { should respond_to :remember_digest, :remember_token, :remember, :forget }

  it { should have_db_index :crew_id }
  it { should have_db_index(:login).unique }
  it { should have_db_index(:email).unique }
  it { should have_db_index :activation_digest }
  it { should have_db_index :reset_digest }

  it { should validate_presence_of :login }
  it { should validate_presence_of :email }
  it { should validate_presence_of :email_confirmation }

  it { should have_secure_password }
  it { should validate_confirmation_of :email }
  it { should validate_confirmation_of :password }

  it { should validate_length_of(:login).is_at_least(4).is_at_most(255) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(72) }

  it { should validate_uniqueness_of(:login).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should belong_to :crew }
  it { should have_many(:participants).dependent :destroy }


  describe 'validation' do
    context 'when email has an invalid format' do
      it 'is expected to not be valid' do
        %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo_bar+baz.com].each do |invalid_email|
          user.email = user.email_confirmation = invalid_email
          expect(user).to_not be_valid
          expect(user).to have(1).error_on :email
        end
      end
    end

    context 'when email has a valid format' do
      it 'is expected to be valid' do
        %w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn].each do |valid_email|
          user.email = user.email_confirmation = valid_email
          expect(user).to be_valid
          expect(user).to have(:no).errors
        end
      end
    end

    context 'when a crew is not specified' do
      before { user.crew = nil }
      it { expect(user).to be_valid }
    end

    context 'with a blank password' do
      before { user.password = '  ' }
      it 'expected to not be valid' do
        expect(user).to_not be_valid
        expect(user).to have(1).error_on :password
      end
    end

    context 'with nil password' do
      before { user.password = nil }
      it 'expected to not be valid' do
        expect(user).to_not be_valid
        expect(user).to have(1).error_on :password
      end
    end
  end


  context 'when just created' do
    subject { UserAccount.new }

    it { is_expected.to_not be_valid }
    it { is_expected.to_not be_activated }
    it { is_expected.to_not be_an_admin }
  end


  describe '#email' do
    let(:mixed_case_email) { 'Foo@ExAPMle.CoM' }

    it 'is converted to lowercase before save' do
      user.email = user.email_confirmation = mixed_case_email
      user.save!
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end


  describe '#login' do
    let(:mixed_case_login) { "MyMIXEDcaseLoGin" }

    it 'is converted to lowercase before save' do
      user.login = mixed_case_login
      user.save!
      expect(user.reload.login).to eq mixed_case_login.downcase
    end
  end


  describe '#authenticate' do
    context 'with valid password' do
      let(:correct_password) { user.password }
      it { expect(user.authenticate(correct_password)).to be user }
    end

    context 'with invalid password' do
      let(:wrong_password) { '123456' }
      it { expect(user.authenticate(wrong_password)).to_not eq user }
      it { expect(user.authenticate(wrong_password)).to be false }
    end
  end


  describe '#name' do
    it { expect(user.name).to be user.login }
  end


  describe '#to_file_name' do
    it { expect(user.to_file_name).to be user.name }
  end


  describe '#crew' do
    context 'for newly saved user' do
      before { user.save! }
      it { expect(user.reload.crew).to be_blank }
    end
  end


  describe '#participants' do
    subject(:user) { FactoryGirl.create(:user_account, :with_participants) }

    it { expect(user).to have(3).participants }
    it { expect(UserAccount.new).to have(:no).participants }
  end


  describe '#remember' do
    it 'generates a new remember token and digest' do
      expect(user.remember_token).to be nil
      expect(user.remember_digest).to be nil
      user.remember
      new_token = user.remember_token
      new_digest = user.remember_digest
      expect(user.remember_token).to_not be nil
      expect(user.remember_digest).to_not be nil
      user.reload
      expect(user.remember_token).to eq new_token
      expect(user.remember_digest).to eq new_digest
    end
  end


  describe '#forget' do
    before do
      user.save!
      user.remember
    end


    it 'clears a remember token and digest' do
      user.forget
      expect(user.remember_token).to be nil
      expect(user.remember_digest).to be nil
      expect(user.reload.remember_digest).to be nil
    end
  end


  describe '#authenticated?' do
    before do
      user.remember
      @remember_token = user.remember_token
    end

    context 'when the user is not remembered' do
      before { user.forget }
      it { expect(user.authenticated? @remember_token).to be false }
    end

    context 'when the user is remembered' do
      it { expect(user.authenticated? @remember_token).to be true }
    end

    context 'when the incorrect remember token passed' do
      it { expect(user.authenticated? '123456').to be false }
      it { expect(user.authenticated? nil).to be false }
    end
  end
end


=begin
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
=end
