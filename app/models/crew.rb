class Crew < ActiveRecord::Base
  has_many :user_accounts

  validates :name, :native_name, presence: true, uniqueness: { case_sensitive: false }

  def emails
    leads.map { |user| user.email }
  end


  def leads
    participants.select { |p| p.user_account.crew_lead? }.map { |p| p.user_account }
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
