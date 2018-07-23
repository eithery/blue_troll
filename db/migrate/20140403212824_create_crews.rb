class CreateCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :crews do |t|
      t.string :name, null: false
      t.string :native_name, null: false
      t.boolean :active, null: false, default: true
      t.string :location
      t.text :notes
      t.timestamps null: false
    end

    add_index :crews, :name, unique: true
    add_index :crews, :native_name, unique: true
  end
end
