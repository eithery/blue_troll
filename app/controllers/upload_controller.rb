require 'csv'

class UploadController < ApplicationController
  def select_file
  end


  def upload_file
		crews = {}
		Crew.all.each { |crew| crews[crew.name] = crew }
  	tmp = params[:file_upload][:selected_file].tempfile

		CSV.foreach(tmp.path) do |row|
			participant = Participant.new(last_name: row[1].strip, first_name: row[2].strip, crew: crews[row[0].strip],
				child: age_category(row[3]))
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
end
