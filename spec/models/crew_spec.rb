require 'spec_helper'

describe Crew do
  before { @crew = Crew.new(name: 'Volchij Khvost', native_name: 'Волчий Хвост') }
  subject { @crew }
  
  it { should respond_to :name }
  it { should respond_to :native_name }
  it { should respond_to :active? }
  it { should respond_to :location }
  it { should respond_to :emails }
  it { should respond_to :participants }
  it { should respond_to :notes }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }
  it { should respond_to :total_participants }
  it { should respond_to :total_adults }
  it { should respond_to :total_children }
  it { should respond_to :total_babies }
  it { should respond_to :to_file_name }

  it { should be_valid }

  it { should be_active }


  describe "when name" do
    context "is not present" do
      before { @crew.name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { @crew.name = nil }
      it { should_not be_valid }
    end

    context "is duplicated" do
      before do
        existing_crew = @crew.dup
        existing_crew.name = @crew.name.upcase
        existing_crew.save
      end
      it { should_not be_valid }
    end
  end


  describe "when native_name" do
    context "is not present" do
      before { @crew.native_name = "  " }
      it { should_not be_valid }
    end

    context "is nil" do
      before { @crew.native_name = nil }
      it { should_not be_valid }
    end

    context "is duplicated" do
      before do
        existing_crew = @crew.dup
        existing_crew.native_name = @crew.native_name.upcase
        existing_crew.save
      end
      it { should_not be_valid }
    end
  end


  describe "#to_s" do
    it "returns name" do
      @crew.to_s.should == @crew.name
    end
  end


  describe "#to_file_name" do
    it "converts name to lowercase replacing space symbols with underscores" do
      @crew.to_file_name.should == 'volchij_khvost'
    end
  end
end
