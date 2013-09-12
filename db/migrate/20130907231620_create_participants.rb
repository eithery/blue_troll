class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :crew_id, null: false
      t.integer :family_id
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :middle_name
      t.string :gender
      t.date :birth_date
      t.string :home_phone
      t.string :cell_phone
      t.string :email
      t.integer :address_id
      t.string :child, null: false, default: :adult
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
