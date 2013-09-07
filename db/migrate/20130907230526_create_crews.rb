class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.string :name, limit: 255, null: false
      t.string :native_name, limit: 255
      t.text :description
      t.string :commander, limit: 255
      t.string :location, limit: 255
      t.string :web_site, limit: 255
      t.string :email, limit:255
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
