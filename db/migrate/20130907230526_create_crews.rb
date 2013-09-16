class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.string :name, null: false
      t.string :native_name, null: false
      t.text :description
      t.integer :lead_id
      t.string :location
      t.string :web_site
      t.string :email
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
