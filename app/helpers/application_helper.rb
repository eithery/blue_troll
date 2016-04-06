# Eithery Lab, 2016.
# ApplicationHelper.
# Provides helper methods mixed in and used within the app.

module ApplicationHelper
  def full_title(page_title)
    base_title = "Blue Trolley"
    page_title.blank? ? base_title : "#{base_title} | #{page_title}"
  end


  def form_title_for(model)
    op = model.new_record? ? 'New' : 'Edit'
    "#{op} #{model.class.name.capitalize}"
  end


  def active_if(selected_view, view)
    selected_view.to_sym == view.to_sym ? 'active' : ''
  end


  def validation_result_for(obj, field)
    msg = obj.errors[field].any? ? "#{field.to_s.humanize} #{obj.errors[field].first}" : ''
    { validation_message: msg }
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
