# Eithery Lab, 2016.
# Blue Trolley event model migration.
# Creates events data table.

require_relative 'helpers/table_definition'

class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :started_on
      t.date :finished_on
      t.string :address
      t.text :notes

      t.full_timestamps

      t.index :name, unique: true
    end
  end
end
