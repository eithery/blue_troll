# Eithery Lab, 2016.
# Blue Trolley Crew model migration.
# Creates crews data table.

require_relative 'helpers/table_definition'

class CreateCrews < ActiveRecord::Migration[5.0]
  def change
    create_table :crews do |t|
      t.string :name, null: false
      t.string :native_name, null: false
      t.boolean :active, null: false, default: true
      t.string :location
      t.text :notes

      t.full_timestamps

      t.index :name, unique: true
      t.index :native_name, unique: true
    end
  end
end
