class EventCrew < ActiveRecord::Base
	has_many :participants

	belong_to :event
end
