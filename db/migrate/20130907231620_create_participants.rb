class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :crew_id
      t.integer :family_id
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :gender
      t.date :birth_date
      t.string :home_phone
      t.string :cell_phone
      t.string :email
      t.integer :address_id
      t.string :child
      t.boolean :active

      t.timestamps
    end
  end
end
