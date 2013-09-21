require 'spec_helper'

describe Participant do
  before do
    hvost = Crew.new(name: 'Volchij Hvost', native_name: 'Волчий Хвост')
    @participant = Participant.new(last_name: 'Romanova', first_name: 'Maria', crew: hvost)
  end
  subject { @participant }

  it { should respond_to(:last_name) }
  it { should respond_to(:first_name) }
  it { should respond_to(:crew) }
  it { should respond_to(:ticket_code) }

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
