require 'spec_helper'

describe Crew do
  let(:crew) { FactoryGirl.build(:crew) }
  let(:fix) { FactoryGirl.create(:fix) }
  let(:second_lead) { FactoryGirl.create(:active_user, crew_lead: true) }
  let(:gaby) { Participant.new(user_account: second_lead, crew: fix.crew, last_name: 'Shayk', first_name: 'Gaby') }

  subject { crew }

  it { should respond_to :name, :native_name, :active?, :location, :notes, :created_at, :updated_at }
  it { should respond_to :participants }
  it { should respond_to :total_participants, :total_adults, :total_children, :total_babies }

  it { should respond_to :emails, :leads }
  it { should respond_to :to_file_name }

  it { should be_valid }
  it { should be_active }


  describe "when name" do
    context "is not present" do
      before { crew.name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { crew.name = nil }
      it { should_not be_valid }
    end

    context "is duplicated" do
      before do
        existing_crew = crew.dup
        existing_crew.name = crew.name.upcase
        existing_crew.save
      end
      it { should_not be_valid }
    end
  end


  describe "when native_name" do
    context "is not present" do
      before { crew.native_name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { crew.native_name = nil }
      it { should_not be_valid }
    end

    context "is duplicated" do
      before do
        existing_crew = crew.dup
        existing_crew.native_name = crew.native_name.upcase
        existing_crew.save
      end
      it { should_not be_valid }
    end
  end


  describe "#leads" do
    describe "returns user accounts who are leads of this crew" do
      specify { fix.crew.leads.should have_at_least(1).user }
      specify { fix.crew.leads.should include(fix.user_account) }
    end

    describe "can contain more than one user account" do
      before { fix.crew.participants << gaby }

      specify { fix.crew.leads.should have(2).users }
      specify { fix.crew.leads.should include(gaby.user_account) }
    end
  end


  describe "#emails" do
    describe "returns the collection of crew leads emails" do
      specify { fix.crew.emails.should have_at_least(1).record }
      specify { fix.crew.emails.should include(fix.email) }
    end

    describe "can contain more than one email" do
      before { fix.crew.participants << gaby }

      specify { fix.crew.emails.should have(2).records }
      specify { fix.crew.emails.should include(gaby.email) }
    end
  end


  describe "#to_s" do
    it "returns name" do
      crew.to_s.should == crew.name
    end
  end


  describe "#to_file_name" do
    it "converts name to lowercase replacing space symbols with underscores" do
      crew.to_file_name.should == 'guests'
    end
  end
end
