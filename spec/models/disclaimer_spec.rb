# Eithery Lab, 2016.
# Disclaimer model specs.

require 'rails_helper'

describe Disclaimer do
  let(:participant) { FactoryGirl.build :event_participant, :with_event_crew }
  subject(:disclaimer) { Disclaimer.new participant }

  it { should respond_to :participant, :to_pdf, :file_name }


  describe '#participant' do
    it { expect(disclaimer.participant).to be participant }
  end


  describe '#file_name' do
    before do
      participant.person.first_name = 'Gwen'
      participant.person.last_name = 'Hvost'
      participant.event.started_on = participant.event.finished_on = Time.now.to_date
    end

    it { expect(disclaimer.file_name).to eq "hvost_gwen_#{Time.now.year}.pdf" }
  end


  describe '#to_pdf' do
    it { expect(disclaimer.to_pdf).to be_a Disclaimer }
  end
end
