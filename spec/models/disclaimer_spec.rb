# Eithery Lab, 2016.
# Disclaimer model specs.

require 'rails_helper'

describe Disclaimer do
  let(:participant) { FactoryGirl.build :event_participant, :with_event_crew }
  subject(:disclaimer) { Disclaimer.new participant }

  it { should respond_to :participant, :to_pdf, :file_name }
  it { should respond_to :ticket_code }
  it { should respond_to :crew_name, :crew_native_name }
  it { should respond_to :age_category, :participant_address }
  it { should respond_to :event_title, :event_address, :event_dates, :event_year }


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
    it { expect(disclaimer.to_pdf).to be_kind_of Prawn::Document }
  end


  describe '#ticket_code' do
    context 'when a participant is approved' do
      include_context 'upcoming event'
      before { participant.approve crew_lead }

      it { expect(disclaimer.ticket_code).to_not be nil }
      it { expect(disclaimer.ticket_code).to eq participant.ticket_code }
    end

    context 'when a participant is not approved' do
      before { participant.ticket_code = nil }
      it { expect(disclaimer.ticket_code).to eq '0000000000' }
    end
  end


  describe '#crew_name' do
    before { participant.crew.prototype.name = 'Wolf tail' }
    it { expect(disclaimer.crew_name).to eq 'Wolf tail' }
  end


  describe '#crew_native_name' do
    before { participant.crew.prototype.native_name = 'Бобры' }
    it { expect(disclaimer.crew_native_name).to eq 'Бобры' }
  end


  describe '#age_category' do
    context 'for adults' do
      before { participant.person.adult! }
      it { expect(disclaimer.age_category).to eq 'A' }
    end

    context 'for children' do
      before { participant.person.child! }

      context 'with specified age' do
        before { participant.person.age = 18 }
        it { expect(disclaimer.age_category).to eq 'C 18' }
      end

      context 'when age is unknown' do
        before { participant.person.age = nil }
        it { expect(disclaimer.age_category).to eq 'C ____' }
      end
    end

    context 'for babies' do
      before { participant.person.baby! }

      context 'with specified age' do
        before { participant.person.age = 3 }
        it { expect(disclaimer.age_category).to eq 'B 3' }
      end

      context 'when age is unknown' do
        before { participant.person.age = nil }
        it { expect(disclaimer.age_category).to eq 'B ____' }
      end
    end
  end


  describe '#participant_address' do
    context 'when address is specified' do
      before { participant.person.address = "52 Mapple street \nBrooklyn \n NY  10005" }
      it { expect(disclaimer.participant_address).to eq '52 Mapple street Brooklyn NY 10005' }
    end

    context 'wnen address is unknown' do
      before { participant.person.address = nil }
      it { expect(disclaimer.participant_address).to eq '' }
    end
  end


  describe '#event_title' do
    before { participant.event.name = 'Blue Trolley' }
    it { expect(disclaimer.event_title).to eq 'Blue Trolley' }
  end


  describe '#event_address' do
    before { participant.event.address = "2315 Hollow Road  \nEast Stroudsburg\n  PA" }
    it { expect(disclaimer.event_address).to eq '2315 Hollow Road East Stroudsburg PA' }
  end


  describe '#event_dates' do
    before { participant.event.started_on = DateTime.new 2016, 6, 10 }

    context 'for multi-days events' do
      before { participant.event.finished_on = DateTime.new 2016, 6, 12 }
      it { expect(disclaimer.event_dates).to eq 'Friday, June 10 - Sunday, June 12' }
    end

    context 'for one-day events' do
      before { participant.event.finished_on = participant.event.started_on }
      it { expect(disclaimer.event_dates).to eq 'Friday, June 10' }
    end
  end


  describe '#event_year' do
    before { participant.event.started_on = DateTime.new 2016, 6, 10 }
    it { expect(disclaimer.event_year).to eq '2016' }
  end
end
