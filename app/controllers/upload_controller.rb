class UploadController < ApplicationController
  def select_file
  end


  def upload_file
  	tmp = params[:file_upload][:selected_file].tempfile
		file = File.join("data", params[:file_upload][:selected_file].original_filename)
		FileUtils.cp tmp.path, file
		render 'select_file'
  end
end
