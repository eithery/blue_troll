# Eithery Lab, 2016.
# Crew model migration.
# Creates crews data table.

require_relative 'helpers/table_definition'

class CreateCrews < ActiveRecord::Migration[5.0]
  def change
    create_table :crews do |t|
      t.belongs_to :event_type, null: false, index: true

      t.string :name, null: false
      t.string :native_name, null: false
      t.boolean :active, null: false, default: true
      t.string :location
      t.text :notes

      t.full_timestamps

      t.index :name, unique: true
      t.index :native_name, unique: true

      t.foreign_key :event_types
    end
  end
end
