require 'spec_helper'

describe Crew do
  before { @crew = Crew.new(name: 'Volchij Khvost', native_name: 'Волчий Хвост') }
  subject { @crew }
  
  it { should respond_to :name }
  it { should respond_to :native_name }
  it { should respond_to :active? }
  it { should respond_to :location }
  it { should respond_to :email }
  it { should respond_to :notes }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }

  it { should be_valid }
  it { should be_active }
end
