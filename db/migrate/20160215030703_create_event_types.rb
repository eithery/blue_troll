# Eithery Lab, 2016.
# EventType model migration.
# Creates event_types data table.

class CreateEventTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :event_types do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :enabled, null: false, default: 1
      t.integer :ordinal, limit: 1

      t.index :name, unique: true
    end
  end
end
