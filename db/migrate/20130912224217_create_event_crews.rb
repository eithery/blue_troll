class CreateEventCrews < ActiveRecord::Migration
  def change
    create_table :event_crews do |t|

      t.timestamps
    end
  end
end
