class AddFlaggedToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :flagged, :bool, null: false, default: false
    add_column :participants, :notes, :text
  end
end
