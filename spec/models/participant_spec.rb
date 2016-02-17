# Eithery Lab, 2016.
# Participant model specs.

require 'rails_helper'

describe Participant do
  subject(:participant) { FactoryGirl.build :participant }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :user_account, :crew }
  it { should respond_to :last_name, :first_name, :middle_name, :gender, :age_category, :age, :born_on }
  it { should respond_to :home_phone, :cell_phone, :email, :address, :notes }
  it { should respond_to :crew_lead?, :financier?, :gatekeeper? }

  it { should validate_presence_of :user_account }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :age_category }

  it { should have_db_index :user_account_id }
  it { should have_db_index :last_name }
  it { should have_db_index :email }

  it { should belong_to(:user_account).inverse_of :participants }


  context 'when just created' do
    subject { Participant.new }

    it { is_expected.to_not be_valid }
    it { is_expected.to_not be_a_crew_lead }
    it { is_expected.to_not be_a_financier }
    it { is_expected.to_not be_a_gatekeeper }
  end


  describe "#crew" do
    it "is the same as user account crew" do
      expect(participant.crew).to_not be_nil
      expect(participant.crew).to eq participant.user_account.crew
    end
  end
end


=begin




  describe "#full_name" do
    it "concatenates last name and first name" do
      gwen.full_name.should == "Hvostan, Gwen"
    end
  end


  describe "#display_name" do
    it "looks like first name concatenates with the last name" do
      gwen.display_name.should == "Gwen Hvostan"
    end
  end


  describe "#email" do
    subject { gwen.email }
    context "when it is not set for participant" do
      before do
        gwen.email = "  "
        gwen.save
      end

      it { should == gwen.user_account.email }
    end

    context "when it is different from user account email" do
      let(:gwen_second_email) { 'gwen_second@gmail.com' }
      before do
        gwen.email = gwen_second_email
        gwen.save
      end

      it { should == gwen_second_email }
    end
  end


def   describe "#ticket code" do
    context "for new participant" do
      let(:new_participant) { FactoryGirl.build(:gaby) }
      subject { new_participant }
      its(:ticket_code) { should_not be_blank }
    end

    its(:ticket_code) { should have_at_least(10).symbols }
  end


  describe "#approved?" do
    context "when NOT approved by crew lead" do
      before { gwen.approved_at = nil }
      its(:approved?) { should be false }
    end

    context "when approved by crew lead" do
      before { gwen.approved_at = Time.now }
      its(:approved?) { should be true }
    end
  end


  describe "#payment_sent?" do
    context "when payment is NOT sent" do
      before { gwen.payment_sent_at = nil }
      its(:payment_sent?) { should be false }
    end

    context "when payment is sent" do
      before { gwen.payment_sent_at = Time.now }
      its(:payment_sent?) { should be true }
    end
  end


  describe "#payment_received?" do
    context "when payment is NOT received by crew lead" do
      before { gwen.payment_received_at = nil }
      its(:payment_received?) { should be false }
    end

    context "when payment is received by crew lead" do
      before { gwen.payment_received_at = Time.now }
      its(:payment_received?) { should be true }
    end
  end


  describe "#payment_confirmed?" do
    context "when payment is NOT confirmed by financier" do
      before { gwen.payment_confirmed_at = nil }
      its(:payment_confirmed?) { should be false }
    end

    context "when payment is confirmed by financier" do
      before { gwen.payment_confirmed_at = Time.now }
      its(:payment_confirmed?) { should be true }
    end
  end


  describe "#approve" do
    before do
      gwen.approve crew_lead
      gwen.reload
    end

    its(:approved?) { should be true }
    its(:approved_at) { should_not be_blank }
    its(:approved_by) { should == crew_lead.login }
  end


  describe "#send_payment" do
    before do
      payment = Payment.new(gwen.user_account, amount: 45.0, payment_type: PaymentType::CASH)
      gwen.send_payment payment
      gwen.reload
    end

    its(:payment_sent?) { should be true }
    its(:payment_sent_at) { should_not be_blank }
    its(:payment_sent_by) { should == gwen.user_account.login }
  end


  describe "#receive_payment" do
    before do
      gwen.receive_payment 45.00, crew_lead
      gwen.reload
    end

    its(:payment_received?) { should be true }
    its(:payment_received_at) { should_not be_blank }
    its(:payment_received_by) { should == crew_lead.login }
  end


  describe "#confirm_payment" do
    before do
      gwen.confirm_payment 45.00, financier
      gwen.reload
    end

    its(:payment_confirmed?) { should be true }
    its(:payment_confirmed_at) { should_not be_blank }
    its(:payment_confirmed_by) { should == financier.login }
  end


  describe ".find_by_ticket" do
    context "when ticket code is valid" do
      it "returns participant for specified ticket code" do
        valid_ticket_code = gwen.ticket_code.to_i(16).to_s
        Participant.find_by_ticket(valid_ticket_code).should == gwen
      end
    end

    context "when ticket code is not valid" do
      it "returns nil" do
        invalid_ticket_code = '1234567890'
        Participant.find_by_ticket(invalid_ticket_code).should be_nil
      end
    end
  end
end
=end