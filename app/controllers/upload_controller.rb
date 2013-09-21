require 'csv'

class UploadController < ApplicationController
  def select_file
  end


  def upload_file
  	tmp = params[:file_upload][:selected_file].tempfile
		crew = Crew.find_by_name('My People')
		CSV.foreach(tmp.path) do |row|
			participant = Participant.new(last_name: row[0], first_name: row[1], crew: crew)
			participant.save!
		end

		render 'select_file'
  end
end
