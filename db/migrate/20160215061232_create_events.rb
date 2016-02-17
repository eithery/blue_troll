# Eithery Lab, 2016.
# Blue Trolley Event model migration.
# Creates events data table.

require_relative 'helpers/table_definition'

class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :event_type, null: false, index: true

      t.string :name, null: false
      t.date :started_on
      t.date :finished_on
      t.string :address
      t.text :notes

      t.full_timestamps

      t.index :name, unique: true
      t.foreign_key :event_types
    end
  end
end
