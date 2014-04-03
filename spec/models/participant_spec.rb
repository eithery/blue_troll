require 'spec_helper'

describe Participant do
  before do
    maryika = UserAccount.new(login: 'maryika', email: 'maryika@gmail.com',
    email_confirmation: 'maryika@gmail.com', password: 'secret', password_confirmation: 'secret')
    hvost = Crew.new(name: 'Volchij Hvost', native_name: 'Волчий Хвост')
    @participant = Participant.new(last_name: 'Romanova', first_name: 'Maria', crew: hvost, user_account: maryika)
  end
  subject { @participant }

  it { should respond_to :crew }
  it { should respond_to :user_account }
  it { should respond_to :last_name }
  it { should respond_to :first_name }
  it { should respond_to :middle_name }
  it { should respond_to :gender }
  it { should respond_to :age_category }
  it { should respond_to :age }
  it { should respond_to :born_on }
  it { should respond_to :home_phone }
  it { should respond_to :cell_phone }
  it { should respond_to :email }
  it { should respond_to :address_line_1 }
  it { should respond_to :address_line_2 }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip }
  it { should respond_to :country }
  it { should respond_to :ticket_code }
  it { should respond_to :flagged? }
  it { should respond_to :notes }
  it { should respond_to :approved_at }
  it { should respond_to :approved_by }
  it { should respond_to :registered_at }
  it { should respond_to :registered_by }
  it { should respond_to :payment_type }
  it { should respond_to :payment_sent_at }
  it { should respond_to :payment_sent_by }
  it { should respond_to :payment_notes }
  it { should respond_to :payment_received_at }
  it { should respond_to :payment_received_by }
  it { should respond_to :payment_confirmed_at }
  it { should respond_to :payment_confirmed_by }
  it { should respond_to :created_by }
  it { should respond_to :updated_by }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }

  it { should be_valid }


  describe "when last_name" do
    context "is not present" do
      before { @participant.last_name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { @participant.last_name = nil }
      it { should_not be_valid }
    end
  end


  describe "when first name" do
    context "is not present" do
      before { @participant.first_name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { @participant.first_name = nil }
      it { should_not be_valid }
    end
  end


  describe "#full_name" do
    it "concatenates last name and first name" do
      @participant.full_name.should == "Romanova, Maria"
    end
  end


  context "when crew is not set" do
    before { @participant.crew = nil }
    it { should_not be_valid }
  end


  context "when user account is not set" do
    before { @participant.user_account = nil }
    it { should_not be_valid }
  end


  describe "ticket code" do
    it "length should always be 10 symbols" do
      @participant.ticket_code.length.should == 10
    end
  end
end
