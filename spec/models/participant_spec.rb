# Eithery Lab, 2016.
# Participant model specs.

require 'rails_helper'

describe Participant do
  subject(:participant) { FactoryGirl.build :participant }
  let(:gwen) { FactoryGirl.build :participant, last_name: 'Hvostan', first_name: 'Gwen' }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'
  it_behaves_like 'it performs email format validation' do
    let(:email_holder) { participant }
  end

  it { should respond_to :user_account }
  it { should respond_to :last_name, :first_name, :middle_name, :gender, :age_category, :age, :born_on }
  it { should respond_to :home_phone, :cell_phone, :email, :address, :notes }
  it { should respond_to :full_name, :display_name }

  it { should validate_presence_of :last_name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :age_category }

  it { should have_db_index :user_account_id }
  it { should have_db_index :last_name }
  it { should have_db_index :email }

  it { should belong_to(:user_account).inverse_of :participants }


  describe 'validation' do
    context 'when a user account is not set' do
      before { participant.user_account = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :user_account }
    end
  end


  describe '#full_name' do
    it 'concatenates last name and first name' do
      expect(gwen.full_name).to eq "Hvostan, Gwen"
    end
  end


  describe '#display_name' do
    it 'concatenates last name and first name' do
      expect(gwen.display_name).to eq "Gwen Hvostan"
    end
  end


  describe '#email' do
    let(:other_email) { 'other_email@gmail.com' }

    context 'when email is not set for a participant' do
      before { participant.email = nil }

      it { expect(participant.email).to_not be_blank }
      it { expect(participant.email).to eq participant.user_account.email }
    end

    context 'when email differs from the user account email' do
      before { participant.email = other_email }

      it { expect(participant.email).to_not be_blank }
      it { expect(participant.email).to eq other_email }
    end

    context 'when email is the same as the user account email' do
      before { participant.email = participant.user_account.email }

      it { expect(participant.email).to_not be_blank }
      it { expect(participant.email).to eq participant.user_account.email }
    end

    context 'when the user account email is blank' do
      before do
        participant.email = nil
        participant.user_account.email = nil
      end

      it { expect(participant.email).to be nil }
    end
  end
end
