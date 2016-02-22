# Eithery Lab, 2016.
# UserAccount model specs.

require 'rails_helper'

describe UserAccount do
  subject(:user) { FactoryGirl.build :user_account }
  let(:admin) { FactoryGirl.build :admin }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'
  it_behaves_like 'it performs email format validation' do
    let(:email_holder) { user }
  end

  it { should respond_to :login, :email, :email_confirmation }
  it { should respond_to :password, :password_confirmation, :password_digest }
  it { should respond_to :admin? }
  it { should respond_to :authenticate, :authenticated? }
  it { should respond_to :remember_digest, :remember_token, :remember, :forget }
  it { should respond_to :activation_digest, :activated?, :activated_at }
  it { should respond_to :reset_digest, :reset_sent_at }
  it { should respond_to :participants, :persons }
  it { should respond_to :name, :to_file_name }
  it { should respond_to :crew_lead_of?, :crew_lead_for?, :financier_of?, :financier_for? }
  it { should respond_to :can_approve?, :can_receive_payment_of?, :can_confirm_payment_of? }
  it { expect(UserAccount).to respond_to :digest }

  it { should have_db_index(:login).unique }
  it { should have_db_index(:email).unique }

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

  it { should have_many(:participants).dependent :destroy }


  describe 'validation' do
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
    it { expect(UserAccount.new).to_not be_valid }
    it { expect(UserAccount.new).to_not be_activated }
    it { expect(UserAccount.new).to_not be_an_admin }
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


  describe '#participants, #persons' do
    let(:user) { FactoryGirl.create(:user_account, :with_participants) }

    it { expect(user).to have(3).persons }
    it { expect(UserAccount.new).to have(:no).persons }
  end


  describe '#remember' do
    it 'generates a new remember token and digest' do
      expect(user.remember_token).to be nil
      expect(user.remember_digest).to be nil
      user.remember
      new_token = user.remember_token
      new_digest = user.remember_digest
      expect(user.remember_token).to_not be_blank
      expect(user.remember_digest).to_not be_blank
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


  describe '#activation_token, #activation_digest' do
    context 'for a new user account' do
      it { expect(user.activation_token).to be nil }
      it { expect(user.activation_digest).to be nil }
    end

    context 'for the first-time saved user account' do
      before { user.save! }

      it { expect(user.activation_token).to_not be_blank }
      it { expect(user.activation_digest).to_not be_blank }
      it { expect(user.activation_digest).to have_at_least(20).characters }
      it { expect(user.activation_token).to have(22).characters }
    end
  end


  describe '.digest' do
    it { expect(UserAccount.digest('some_string')).to_not be_blank }
    it { expect(UserAccount.digest('some_string')).to have_at_least(20).characters }
  end


  describe '#financier_of' do
  end


  describe '#financier_for' do
    include_context 'upcoming event'
  end


  describe '#crew_lead_of' do
  end


  describe '#crew_lead_for' do
    include_context 'upcoming event'
  end


  describe '#can_approve?' do
    include_context 'upcoming event'

    context 'when a participant is already approved' do
      before { participant.approved_at = Time.now }
      it { expect(crew_lead.user.can_approve? participant).to be false }
    end

    context 'when a user is not a crew lead' do
      it { expect(other_participant.user.can_approve? participant).to be false }
    end

    context 'when a user is a crew lead of an other crew' do
      it { expect(other_crew_lead.user.can_approve? participant).to be false }
    end

    context 'when a user is a valid crew lead' do
      it { expect(crew_lead.user.can_approve? participant).to be true }
    end

    context 'when a user is a crew lead but not at this event' do
      it { expect(other_event_crew_lead.user.can_approve? participant).to be false }
    end

    context 'when a user is an admin' do
      it { expect(admin.can_approve? participant).to be true }
    end
  end


  describe '#can_receive_payment?' do
    include_context 'upcoming event'

    context 'when payment is already received' do
      before { participant.payment_received_at = Time.now }
      it { expect(crew_lead.user.can_receive_payment_of? participant).to be false }
    end

    context 'when a user is not a crew lead' do
      it { expect(other_participant.user.can_receive_payment_of? participant).to be false }
    end

    context 'when a user is a crew lead of an other crew' do
      it { expect(other_crew_lead.user.can_receive_payment_of? participant).to be false }
    end

    context 'when a user us a valid crew lead' do
      it { expect(crew_lead.user.can_receive_payment_of? participant).to be true }
    end

    context 'when a user is a crew lead but not at this event' do
      it { expect(other_event_crew_lead.user.can_receive_payment_of? participant).to be false }
    end

    context 'when a user is a financier' do
      it { expect(financier.user.can_receive_payment_of? participant).to be true }
    end

    context 'when a user is a financier but not at this event' do
      it { expect(other_financier.user.can_receive_payment_of? participant).to be false}
    end

    context 'when a user is an admin' do
      it { expect(admin.can_receive_payment_of? participant).to be true }
    end
  end


  describe '#can_confirm_payment?' do
    include_context 'upcoming event'

    context 'when payment is already confirmed' do
      before { participant.payment_confirmed_at = Time.now }
      it { expect(financier.user.can_confirm_payment_of? participant).to be false }
    end

    context 'when a user is not a crew lead' do
      it { expect(other_participant.user.can_confirm_payment_of? participant).to be false }
    end

    context 'when a user us a valid crew lead' do
      it { expect(crew_lead.user.can_confirm_payment_of? participant).to be false }
    end

    context 'when a user is a financier' do
      it { expect(financier.user.can_confirm_payment_of? participant).to be true }
    end

    context 'when a user is a financier but not at this event' do
      it { expect(other_financier.user.can_confirm_payment_of? participant).to be false}
    end

    context 'when a user is an admin' do
      it { expect(admin.can_confirm_payment_of? participant).to be true }
    end
  end
end
