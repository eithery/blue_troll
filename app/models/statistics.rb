# Eithery Lab, 2016.
# Statistics module.
# Retrieves an event statistics info.

module Statistics
  def adults_total
    participants.count { |p| p.adult? }
  end


  def adults_paid_total
    participants.count { |p| p.adult? && p.paid? }
  end


  def adults_onsite_total
    participants.count { |p| p.adult? && p.checked_in? }
  end


  def children_total
    participants.count { |p| p.child? }
  end


  def children_paid_total
    participants.count { |p| p.child? && p.paid? }
  end


  def children_onsite_total
    participants.count { |p| p.child? && p.checked_in? }
  end


  def babies_total
    participants.count { |p| p.baby? }
  end


  def babies_paid_total
    participants.count { |p| p.baby? && p.paid? }
  end


  def babies_onsite_total
    participants.count { |p| p.baby? && p.checked_in? }
  end


  def participants_total
    participants.count
  end


  def participants_paid_total
    participants.count { |p| p.paid? }
  end


  def participants_onsite_total
    participants.count { |p| p.checked_in? }
  end


  def flagged_total
    participants.count { |p| p.flagged? }
  end


  def participants_expected_total
    participants.count { |p| p.paid? && !p.checked_in? }
  end
end
