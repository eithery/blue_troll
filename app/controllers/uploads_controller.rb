require 'csv'

class UploadsController < ApplicationController
  def select_participants_file
  end


  def upload_participants
    crews = {}
    Crew.all.each { |c| crews[c.name] = c }
    tmp = params[:upload][:participants_file].tempfile
    total_participants = 0

    CSV.foreach(tmp.path) do |row|
      crew_name = row[7].strip
      last_name = row[0].strip.capitalize
      first_name = row[1].strip.capitalize
      first_name = 'n/a' if first_name.blank?
      category = age_category(row[2])
      age = row[6]

      crew = crews[map_crew_name(crew_name)]
      crew_lead = crew.leads.last

      participant = find_participant(crew_lead, last_name, first_name)
      if participant.nil?
        participant = Participant.new(user_account: crew_lead, last_name: last_name, first_name: first_name)
        participant.age_category = category
        participant.age = age.to_i unless age.blank?
        participant.age = 0 if participant.age_category != AgeCategory::ADULT && participant.age.blank?
        participant.approved_at = participant.payment_confirmed_at = Time.now
        participant.approved_by = participant.payment_confirmed_by = 'ryeliseyev'
        participant.created_by = participant.updated_by = 'admin'
        participant.save!
        total_participants += 1
      end
    end

    flash.now[:success] = "Totally loaded #{total_participants} participants."
    render action: :select_participants_file
  end


 private
  def age_category(age)
    return AgeCategory::CHILD if age.to_i == 1
    return AgeCategory::BABY if age.to_i == 0
    return AgeCategory::ADULT
  end


  def find_participant(crew_lead, last_name, first_name)
    Participant.find(:all, conditions: ["user_account_id = ? and lower(last_name) = ? and lower(first_name) = ?",
      crew_lead.id, last_name.downcase, first_name.downcase]).first
  end


  def map_crew_name(crew_name)
    crews_assoc = {
      /All/i => 'Guests',
      /Razboyniki/i => 'Kazaki-Razboiniki',
      /Pegasus/i => 'Pegassus',
      /TRЯM/i => 'Trjam',
      /donkeys/i => 'Trojan Donkeys'
    }

    crews_assoc.each do |key, value|
      return value if crew_name =~ key
    end

    crew_name
  end
end
