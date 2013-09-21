require 'csv'

class UploadController < ApplicationController
  def select_file
  end


  def upload_file
		crews = {}
		Crew.all.each { |crew| crews[crew.name] = crew }
  	tmp = params[:file_upload][:selected_file].tempfile

		CSV.foreach(tmp.path) do |row|
			participant = Participant.new(last_name: row[1], first_name: row[2], crew: crews[row[0]])
			participant.save!
		end

		render 'select_file'
  end
end
