class UploadController < ApplicationController
  def select
  end

  def file_upload
  	tmp = params[:file_upload][:selected_file].tempfile
		file = File.join("data", params[:file_upload][:selected_file].original_filename)
		FileUtils.cp tmp.path, file
		render 'select'
  end
end
