# Eithery Lab, 2016.
# Disclaimer model specs.

require 'rails_helper'

describe Disclaimer do
  let(:participant) { FactoryGirl.build :event_participant }
  subject(:disclaimer) { Disclaimer.new participant }

  it { should respond_to :participant, :to_pdf, :file_name }


  describe '#participant' do
    it { expect(disclaimer.participant).to be participant }
  end


  describe '#file_name' do
  end


  describe '#to_pdf' do
  end
end
