class CreateEventParticipants < ActiveRecord::Migration
  def change
    create_table :event_participants do |t|
      t.integer :event_id, null: false
      t.integer :participant_id, null: false
      t.integer :event_crew_id, null: false
      t.integer :event_ticket_id
      t.string :ticket_status, null: false
      t.integer :ticket_code
      t.string :reservation_number
      t.string :source, length: 10
      t.date :registered_at
      t.string :registered_by

      t.timestamps
    end
  end
end
