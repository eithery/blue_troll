class Crew < ActiveRecord::Base
  has_many :participants

  validates :name, :native_name, presence: true, uniqueness: { case_sensitive: false }

  def emails
    []
  end


  def to_s
  	name
  end


  def to_file_name
    name.gsub(/\s/, '_').downcase
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
end
