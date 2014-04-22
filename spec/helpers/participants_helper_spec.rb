require 'spec_helper'

describe ParticipantsHelper do
  describe "#all_crews" do
    it "returns all crews" do
      FactoryGirl.create(:crew)
      FactoryGirl.create(:spies)
      FactoryGirl.create(:fix_crew)

      all_crews.should have(3).items
    end


    it "orders crews by name" do
      Crew.should_receive(:order).with(:name)
      all_crews
    end
  end


  describe "#form_header" do
    subject { form_header }

    context "for new participant" do
      before { @participant = mock_participant.as_new_record }
      it { should == "New Participant" }
    end


    context "for existing participant" do
      before { @participant = mock_participant }
      it { should == "Edit Participant" }
    end
  end
end
