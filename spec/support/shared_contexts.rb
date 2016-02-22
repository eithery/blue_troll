# Eithery Lab, 2016.
# Provides RSpec shared contexts.

require 'rails_helper'

shared_context 'upcoming event' do
  let(:event) do
    event = FactoryGirl.create :event
    3.times do |n|
      crew = FactoryGirl.create :crew
      event.crews << FactoryGirl.create(:event_crew, event: event, prototype: crew)
    end

    user = FactoryGirl.create :user_account
    5.times do |n|
      participant = FactoryGirl.create :participant, user_account: user
      FactoryGirl.create :event_participant, person: participant, crew: event.crews.first
    end

    another_user = FactoryGirl.create :user_account
    3.times do |n|
      participant = FactoryGirl.create :participant, user_account: another_user
      FactoryGirl.create :event_participant, person: participant, crew: event.crews.last
    end

    crew_lead = event.crews.first.participants.last
    crew_lead.update_attribute :crew_lead, true

    financier = event.crews.last.participants.last
    financier.update_attributes crew_lead: true, financier: true

    event.save!
    event
  end

  let(:crew) { event.crews.first }
  let(:other_crew) { event.crews.last }
  let(:crew_lead) { crew.leads.first }
  let(:other_crew_lead) { other_crew.leads.last }
  let(:financier) { event.financiers.first }
  let(:participant) { crew.participants.first }
end
