class Statistics
  def adults_registered
    participants.count { |p| p.adult? }
  end


  def adults_paid
    participants.count { |p| p.adult? && p.paid? }
  end


  def adults_onsite
    participants.count { |p| p.adult? && p.checked_in? }
  end


  def children_registered
    participants.count { |p| p.child? }
  end


  def children_paid
    participants.count { |p| p.child? && p.paid? }
  end


  def children_onsite
    participants.count { |p| p.child? && p.checked_in? }
  end


  def babies_registered
    participants.count { |p| p.baby? }
  end


  def babies_paid
    participants.count { |p| p.baby? && p.paid? }
  end


  def babies_onsite
    participants.count { |p| p.baby? && p.checked_in? }
  end


  def participants_registered
    participants.count
  end


  def participants_paid
    participants.count { |p| p.paid? }
  end


  def participants_onsite
    participants.count { |p| p.checked_in? }
  end


  def flagged
    participants.count { |p| p.flagged? }
  end


  def expected
    participants.count { |p| p.paid? && !p.checked_in? }
  end


private

  def participants
    @participants ||= Participant.all.to_a
  end
end
