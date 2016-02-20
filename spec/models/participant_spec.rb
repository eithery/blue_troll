# Eithery Lab, 2016.
# Participant model specs.

require 'rails_helper'

describe Participant do
  subject(:participant) { FactoryGirl.build :participant }
  let(:gwen) { FactoryGirl.build :participant, last_name: 'Hvostan', first_name: 'Gwen' }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

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
#    it_behaves_like 'performing email format check'

    context 'when email is not set for a participant' do
    end

    context 'when email differs from the user account email' do
    end

    context 'when email is the same as the user account email' do
    end

    context 'when the user account email is blank' do
    end
  end
end
