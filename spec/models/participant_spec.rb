require 'spec_helper'

describe Participant do
  before do
    hvost = Crew.new(name: 'Volchij Hvost', native_name: 'Волчий Хвост')
    @participant = Participant.new(last_name: 'Romanova', first_name: 'Maria', crew: hvost)
  end
  subject { @participant }

  it { should respond_to :crew }
  it { should respond_to :user_account }
  it { should respond_to :last_name }
  it { should respond_to :first_name }
  it { should respond_to :middle_name }
  it { should respond_to :gender }
  it { should respond_to :age_category }
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
  it { should respond_to :approved_at }
  it { should respond_to :approved_by }
  it { should respond_to :payment_sent_at }
  it { should respond_to :payment_sent_by }
  it { should respond_to :payment_notes }
  it { should respond_to :payment_confirmed_at }
  it { should respond_to :payment_confirmed_by }
  it { should respond_to :registered_at }
  it { should respond_to :registered_by }
  it { should respond_to :flagged? }
  it { should respond_to :notes }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }

  it { should be_valid }


  context "when last name is not present" do
    before { @participant.last_name = "  " }
    it { should_not be_valid }
  end


  context "when first name is not present" do
    before { @participant.first_name = "  " }
    it { should_not be_valid }
  end


  context "when ticket code is not present" do
    before { @participant.ticket_code = "  " }
    it { should_not be_valid }
  end


  context "when crew is not set" do
    before { @participant.crew = nil }
    it { should_not be_valid }
  end


  describe "ticket code" do
    it "length should always be 10 symbols" do
      @participant.ticket_code.length.should == 10
    end
  end
end
