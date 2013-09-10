class TicketsController < ApplicationController
	def create
		define_native_group_name
		respond_to_pdf Disclaimer.new(params)
	end


	def respond_to_pdf(disclaimer)
		send_data disclaimer.to_pdf, filename: disclaimer.file_name, type: 'application/pdf', disposition: 'attachment'
	end


	def define_native_group_name
		group_name = params[:group]
		Crew.all.each do |crew|
			if crew.name == group_name
				params[:group_native] = crew.native_name
				return
			end
		end
	end
end
