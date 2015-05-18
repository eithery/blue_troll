class StaticPagesController < ApplicationController
  def home
  end


  def statistics
    @stats = Statistics.new
  end


  def event_announcement
    send_file Rails.root.join('app', 'assets', 'docs', 'event_announcement.pdf'), file_name: 'event_announcement.pdf',
      type: 'application/pdf', disposition: 'inline'
  end
end
