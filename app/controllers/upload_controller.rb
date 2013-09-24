require 'csv'

class UploadController < ApplicationController
  def select_file
  end


  def upload_file
		crews = {}
		Crew.all.each { |c| crews[c.name] = c }
  	tmp = params[:file_upload][:selected_file].tempfile

		CSV.foreach(tmp.path) do |row|
      crew_name = row[0].strip
      last_name = row[1].strip.capitalize
      first_name = row[2].strip.capitalize
      category = age_category(row[3])
      import_id = row[4]
      reservation_number = row[5]

      crew = crews[crew_name]
      crew = Crew.find(find_crew_id(crew_name)) if crew.nil?

      participant = find_participant(crew, last_name, first_name)
      participant = Participant.new(last_name: last_name, first_name: first_name, crew: crew, child: category) if participant.nil?
      participant.import_id = import_id.blank? || import_id =~ /NULL/i ? nil : import_id.to_i
      participant.reservation_number = reservation_number
			participant.save!
		end

		render 'select_file'
  end


 private
 	def age_category(age)
 		return 0 if age.to_i == 2
 		return 1 if age.to_i == 1
 		return 2 if age.to_i == 0
 		return 0
 	end


  def find_participant(crew, last_name, first_name)
    Participant.find(:all, conditions: ["crew_id = ? and lower(last_name) = ? and lower(first_name) = ?",
      crew.id, last_name.downcase, first_name.downcase]).first
  end


  def find_crew_id(crew_name)
    crews_assoc = {
      /Звон/ => 1,
      /Беспризорники/ => 2,
      /Барабанщики/ => 3,
      /Дубки/ => 4,
      /Елки/ => 5,
      /Эль-Тор/ => 6,
      /ГТО/ => 7,
      /Голос/ => 10,
      /Казаки/ => 11,
      /Берег/ => 12,
      /Мандамус/ => 13,
      /Свои Люди/ => 14,
      /севера/ => 15,
      /Палата/ => 16,
      /Пегас/ => 17,
      /Разлив/ => 18,
      /Ослики/ => 20,
      /TRЯM/ => 21,
      /Хвост/ => 22,
      /Ворона/ => 23
    }

    crews_assoc.each do |key, value|
      return value if crew_name =~ key
    end
  end
end
