require 'spec_helper'

describe Participant do
  let(:gwen) { FactoryGirl.create(:gwen) }
  subject { gwen }

  it { should respond_to :crew, :user_account  }
  it { should respond_to :last_name, :first_name, :middle_name, :gender, :age_category, :age, :born_on }
  it { should respond_to :home_phone, :cell_phone, :email, :address_line_1, :address_line_2,
    :city, :state, :zip, :country }
  it { should respond_to :ticket_code }
  it { should respond_to :flagged?, :notes, :approved_at, :approved_by, :registered_at, :registered_by }
  it { should respond_to :payment_type, :payment_sent_at, :payment_sent_by, :payment_notes }
  it { should respond_to :payment_received_at, :payment_received_by, :payment_confirmed_at, :payment_confirmed_by }
  it { should respond_to :created_by, :updated_by, :created_at, :updated_at }
  it { should respond_to :full_name, :display_name, :address }
  specify { Participant.should respond_to :find_by_ticket }

  it { should be_valid }

  describe "validation" do
    context "when last_name" do
      context "is not present" do
        before { gwen.last_name = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:last_name) }
      end

      context "is nil" do
        before { gwen.last_name = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:last_name) }
      end
    end


    describe "when first name" do
      context "is not present" do
        before { gwen.first_name = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:first_name) }
      end

      context "is nil" do
        before { gwen.first_name = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:first_name) }
      end
    end

    context "when user account is not set" do
      before { gwen.user_account = nil }
      it { should_not be_valid }
      it { should have(1).error_on(:user_account) }
    end
  end


  describe "#full_name" do
    it "concatenates last name and first name" do
      gwen.full_name.should == "Hvostan, Gwen"
    end
  end


  describe "ticket code" do
    it "length should always be 10 symbols" do
      gwen.ticket_code.length.should == 10
    end
  end
end
