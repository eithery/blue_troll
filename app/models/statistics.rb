class Statistics
  def self.adults_registered
    participants.count { |p| p.age_category == AgeCategory::ADULT }
  end


  def self.adults_onsite
    participants.count { |p| p.age_category == AgeCategory::ADULT && p.registered_at }
  end


  def self.children_registered
    participants.count { |p| p.age_category == AgeCategory::CHILD }
  end


  def self.children_onsite
    participants.count { |p| p.age_category == AgeCategory::CHILD && p.registered_at }
  end


  def self.babies_registered
    participants.count { |p| p.age_category == AgeCategory::BABY }
  end


  def self.babies_onsite
    participants.count { |p| p.age_category == AgeCategory::BABY && p.registered_at }
  end


  def self.participants_registered
    participants.count
  end


  def self.participants_onsite
    participants.count { |p| p.registered_at }
  end


  def self.flagged
    participants.count { |p| p.flagged? }
  end


  def self.expected
    participants.count { |p| !p.registered_at }
  end


private
  def self.participants
    Participant.all.to_a
  end
end
