# Eithery Lab, 2016.
# Event participant model migration.
# Creates event_participants data table.

require_relative 'helpers/table_definition'

class CreateEventParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :event_participants do |t|
      t.belongs_to :event_crew, null: false, index: true
      t.belongs_to :participant, null: false, index: true

      t.string :ticket_code

      t.boolean :crew_lead, null: false, default: false
      t.boolean :financier, null: false, default: false
      t.boolean :gatekeeper, null: false, default: false

      t.boolean :flagged, null: false, default: false
      t.text :notes

      t.datetime :approved_at
      t.string :approved_by
      t.datetime :checked_in_at
      t.string :checked_in_by

      t.integer :payment_type
      t.datetime :payment_sent_at
      t.string :payment_sent_by
      t.string :payment_notes
      t.datetime :payment_received_at
      t.string :payment_received_by
      t.datetime :payment_confirmed_at
      t.string :payment_confirmed_by

      t.full_timestamps

      t.index :ticket_code, unique: true

      t.foreign_key :event_crews
      t.foreign_key :participants
    end
  end
end
