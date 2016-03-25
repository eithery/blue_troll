# Eithery Lab, 2016.
# ApplicationHelper.
# Provides helper methods mixed in and used within the app.

module ApplicationHelper
  def full_title(page_title)
    base_title = "Blue Trolley"
    page_title.blank? ? base_title : "#{base_title} | #{page_title}"
  end


  def baby_image(participant)
    image_tag("baby.png", class: "bt-img-reduced") if participant.category == AgeCategory::BABY
  end


  def red_flag_image(participant)
    image_tag("red_flag.png", class: "bt-img") if participant.flagged?
  end


  def checked_in_image(participant)
    image_tag participant.registered_at.blank? ? 'bulb_off.png' : 'bulb_on.png'
  end


  def visible_if(&block)
    block.call ? "" : "display: none;"
  end


  def visible_unless(&block)
    block.call ? "display: none;" : ""
  end
end
