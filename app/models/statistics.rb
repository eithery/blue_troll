class Statistics
  def self.adults_registered
    participants.count { |p| p.category == :adult }
  end


  def self.adults_onsite
    participants.count { |p| p.category == :adult && p.registered_at }
  end


  def self.children_registered
    participants.count { |p| p.category == :child }
  end


  def self.children_onsite
    participants.count { |p| p.category == :child && p.registered_at }
  end


  def self.babies_registered
    participants.count { |p| p.category == :baby }
  end


  def self.babies_onsite
    participants.count { |p| p.category == :baby && p.registered_at }
  end


  def self.participants_registered
    participants.count
  end


  def self.participants_onsite
    participants.count { |p| p.registered_at }
  end


private
  def self.participants
    @all_participants ||= Participant.all.to_a
  end
end
