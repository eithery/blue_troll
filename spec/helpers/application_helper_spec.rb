# Eithery Lab, 2016.
# ApplicationHelper specs.

require 'rails_helper'

describe ApplicationHelper do
  describe "#full_title" do
    it "includes the page title" do
      expect(full_title 'foo').to match /| foo/
    end

    it "includes a base title" do
      expect(full_title 'foo').to match /Blue Trolley/
    end

    it "does not include a bar for an empty page title" do
      expect(full_title '').to_not match /\|/
    end
  end
end


=begin
  let(:participant) { mock_participant }
  describe "#baby_image" do
    it "returns image tag for baby participants" do
      participant.stub(category: AgeCategory::BABY)
      baby_image(participant).should have_selector('img')
    end

    it "returns nothing for adults and children older than 6" do
      participant.stub(category: AgeCategory::ADULT)
      baby_image(participant).should be_nil

      participant.stub(category: AgeCategory::CHILD)
      baby_image(participant).should be_nil
    end

    it "checks category to display image" do
      participant.should_receive(:category)
      baby_image(participant)
    end
  end


  describe "#red_flag_image" do
    it "returns image tag for flagged participant" do
      participant.stub(flagged?: true)
      red_flag_image(participant).should have_selector('img')
    end

    it "returns nothing for non flagged participant" do
      participant.stub(flagged?: false)
      red_flag_image(participant).should be_nil
    end

    it "uses flagged? method to display image" do
      participant.should_receive(:flagged?)
      red_flag_image(participant)
    end
  end


  describe "#checked_in_image" do
    it "returns image tag" do
      participant.stub(registered_at: Time.now)
      checked_in_image(participant).should have_selector('img')

      participant.stub(registered_at: nil)
      checked_in_image(participant).should have_selector('img')
    end

    it "uses registered_at method to determine image type" do
      participant.should_receive(:registered_at)
      checked_in_image participant
    end
  end
=end