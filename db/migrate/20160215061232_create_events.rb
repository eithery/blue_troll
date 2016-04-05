# Eithery Lab, 2016.
# Event model migration.
# Creates events data table.

require_relative 'helpers/table_definition'

class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :event_type, null: false, index: true

      t.string :name, null: false
      t.string :short_name, length: 20, null: false
      t.date :started_on
      t.date :finished_on
      t.string :address
      t.text :notes
      t.string :tag

      t.full_timestamps

      t.index :name, unique: true
      t.index :short_name, unique: true
      t.foreign_key :event_types
    end
  end
end
