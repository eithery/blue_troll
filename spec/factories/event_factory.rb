# Eithery Lab, 2016.
# Defines factories for Event model.

FactoryGirl.define do
  factory :event do
    name 'Blue Trolley Spring 2016'
    event_type_id 1
    started_on Date.new(2016, 6, 3)
    finished_on Date.new(2016, 6, 5)
    address 'KOA East Stroudsburg PA'
    created_by 'test'
    updated_by 'test'
  end
end
