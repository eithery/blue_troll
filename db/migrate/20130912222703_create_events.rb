class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :event_type, null: false, default: :slet
      t.integer :lead_id
      t.date :from, null: false
      t.date :to, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
