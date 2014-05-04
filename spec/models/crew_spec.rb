require 'spec_helper'

describe Crew do
  # Crews.
  let(:crew) { FactoryGirl.build(:crew) }
  let(:empty_crew) { FactoryGirl.create(:spies) }

  # User accounts.
  let(:crew_lead) { FactoryGirl.create(:crew_lead, crew: gwen.crew) }
  let(:gaby_account) { FactoryGirl.create(:active_user, crew_lead: true, crew: gwen.crew) }

  # Participants.
  let(:gwen) { FactoryGirl.create(:gwen) }
  let(:maryika) { FactoryGirl.create(:maryika, user_account: gwen.user_account) }
  let(:fix) { FactoryGirl.create(:fix, user_account: crew_lead) }
  let(:gaby) { FactoryGirl.create(:gaby, user_account: gaby_account) }

  subject { crew }

  it { should respond_to :name, :native_name, :active?, :location, :notes, :created_at, :updated_at }
  it { should respond_to :user_accounts, :participants }
  it { should respond_to :total_participants, :total_adults, :total_children, :total_babies }

  it { should respond_to :emails, :leads }
  it { should respond_to :to_file_name }
  it { should respond_to :display_name }

  it { should be_valid }
  it { should be_active }


  describe "validation" do
    context "when name" do
      context "is not present" do
        before { crew.name = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:name) }
      end

      context "is nil" do
        before { crew.name = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:name) }
      end

      context "is duplicated" do
        before do
          existing_crew = FactoryGirl.create(:spies)
          crew.name = existing_crew.name.upcase
          crew.save
        end
        it { should_not be_valid }
        it { should have(1).error_on(:name) }
      end
    end


    context "when native_name" do
      context "is not present" do
        before { crew.native_name = "  " }
        it { should_not be_valid }
        it { should have(1).error_on(:native_name) }
      end

      context "is nil" do
        before { crew.native_name = nil }
        it { should_not be_valid }
        it { should have(1).error_on(:native_name) }
      end

      context "is duplicated" do
        before do
          existing_crew = FactoryGirl.create(:spies)
          crew.native_name = existing_crew.native_name.upcase
          crew.save
        end
        it { should_not be_valid }
        it { should have(1).error_on(:native_name) }
      end
    end
  end


  describe "#user_accounts" do
    subject { gwen.crew.user_accounts }
    before { crew_lead }

    specify { gwen.crew.should have(2).user_accounts }
    it { should include(crew_lead, gwen.user_account) }
    specify { empty_crew.should_not have(:any).user_accounts }
  end


  describe "#participants" do
    subject { gwen.crew.participants }
    before { maryika; fix }

    specify { gwen.crew.should have(3).participants }
    it { should include(gwen, maryika, fix) }
    specify { empty_crew.should_not have(:any).participants }
  end


  describe "#leads" do
    subject { gwen.crew.leads }
    before { maryika; fix }

    describe "returns user accounts that are crew leads" do
      it { should have_at_least(1).user }
      it { should include(fix.user_account) }
      it { should_not include(maryika.user_account) }
      specify { empty_crew.should_not have(:any).leads }
    end

    describe "can contain more than one user account" do
      before { gaby }

      it { should have(2).users }
      it { should include(gaby.user_account) }
    end
  end


  describe "#emails" do
    subject { gwen.crew.emails }
    before { maryika; fix }

    describe "returns the collection of crew leads emails" do
      it { should have_at_least(1).record }
      it { should include(fix.email) }
      specify { empty_crew.should_not have(:any).emails }
    end

    describe "can contain more than one email" do
      before { gaby }

      it { should have(2).records }
      it { should include(gaby.email) }
      it { should_not include(maryika.email) }
    end
  end


  describe "#display_name" do
    subject { gwen.crew.display_name }
    it { should == "Konserva Lovers (Любители консервов)"}
  end


  describe "#total_participants" do
    subject { gwen.crew.total_participants }
    before { gwen; maryika; fix }
    it { should == 3 }
  end


  describe "#total_adults" do
    subject { gwen.crew.total_adults }
    before { gwen; maryika; fix }
    it { should == 2 }
  end


  describe "#total_children" do
    subject { gwen.crew.total_children }
    before { gwen; maryika; fix; gaby }
    it { should == 1 }
  end


  describe "#total_babies" do
    subject { gwen.crew.total_babies }
    before { gwen; maryika; fix }
    it { should == 1 }
  end


  describe "#to_s" do
    it "returns name" do
      crew.to_s.should == crew.name
    end
  end


  describe "#to_file_name" do
    it "converts name to lowercase replacing space symbols with underscores" do
      empty_crew.to_file_name.should == 'enemy_spies'
    end
  end
end
