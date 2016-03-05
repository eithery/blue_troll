# Eithery Lab, 2016.
# Defines factories for Event model.

FactoryGirl.define do
  factory :event do
    name { Faker::Hipster.sentence(3) }
    event_type_id 1
    started_on Date.new(2016, 6, 3)
    finished_on Date.new(2016, 6, 5)
    address { Faker::Address.street_address}
    created_by 'test'
    updated_by 'test'

    trait :with_crews do
      after(:build) do |event|
        event.crews << build(:event_crew, event: event, prototype: create(:crew))
        event.crews << build(:event_crew, event: event, prototype: create(:crew))
      end
    end

    trait :with_participants do
      after(:build) do |event|
        event.crews.each do |crew|
          crew.participants << [
            build(:event_participant, crew: crew, gatekeeper: true),
            build(:event_participant, crew: crew, gatekeeper: true),
            build(:event_participant, crew: crew),
            build(:crew_lead, crew: crew),
          ]
        end

        crew = event.crews.first
        crew.participants << build(:financier, crew: crew)
      end
    end
  end
end
