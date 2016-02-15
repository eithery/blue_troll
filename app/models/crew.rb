# Eithery Lab, 2016.
# Crew model.
# Represents Blue Trolley crew.

class Crew < ApplicationRecord
  include NameHolder, Trackable

  validates :native_name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :location, length: { maximum: 255 }
end

=begin
  has_many :user_accounts

  validates :name, :native_name, presence: true, uniqueness: { case_sensitive: false }


  def participants
    user_accounts.inject([]) { |total, user| total + user.participants }.sort_by! { |p| p.last_name + p.first_name } 
  end


  def leads
    user_accounts.select { |user| user.crew_lead? }
  end


  def lead?(user)
    leads.include?(user)
  end


  def emails
    leads.map { |user| user.email }
  end


  def display_name
    "#{self.name} (#{self.native_name})"
  end


  def total_participants
    participants.to_a.count
  end


  def total_adults
    participants.to_a.count { |p| p.age_category == AgeCategory::ADULT }
  end


  def total_children
    participants.to_a.count { |p| p.age_category == AgeCategory::CHILD }
  end


  def total_babies
    participants.to_a.count { |p| p.age_category == AgeCategory::BABY }
  end


  def paid_count
    participants.to_a.count { |p| p.paid? }
  end


  def to_s
  	name
  end


  def to_file_name
    name.gsub(/\s/, '_').downcase
  end
=end
