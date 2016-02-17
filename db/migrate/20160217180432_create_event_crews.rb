# Eithery Lab, 2016.
# Event crew model migration.
# Creates event_crews data table.

require_relative 'helpers/table_definition'

class CreateEventCrews < ActiveRecord::Migration[5.0]
  def change
    create_table :event_crews do |t|
      t.belongs_to :event, null: false, index: true
      t.belongs_to :crew, null: false, index: true

      t.text :notes
      t.full_timestamps

      t.foreign_key :events
      t.foreign_key :crews
    end
  end
end
