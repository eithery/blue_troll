# Eithery Lab, 2016.
# EventCrew model.
# Represents a crew in the particular event.

class EventCrew < ApplicationRecord
  include Trackable

  belongs_to :prototype, class_name: Crew, foreign_key: :crew_id
  belongs_to :event, inverse_of: :crews
  has_many :participants, class_name: EventParticipant


  def name
    prototype.name
  end


  def to_file_name
    name.gsub(/\s/, '_').downcase
  end


  def leads
    participants.select { |p| p.crew_lead? }
  end


  def emails
    participants.map { |p| p.email }.uniq
  end


  def lead_emails
    leads.map { |lead| lead.email }.uniq
  end


  def statistics
    @statistics ||= Statistics.new
  end
end
