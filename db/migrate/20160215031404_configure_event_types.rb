# Eithery Lab, 2016.
# Available event types.
# Populates event_types data table.

class ConfigureEventTypes < ActiveRecord::Migration[5.0]
  def up
    EventType.create! [
      { id: 1, name: 'Blue Trolley event', description: 'Spring or Fall Blue Trolley bard events (slets).', ordinal: 10 },
      { id: 2, name: 'Party', description: 'Parties or celebrations.', ordinal: 20 },
      { id: 3, name: 'Concert', description: 'Concerts or artist performances.', ordinal: 30 },
      { id: 4, name: 'Other', description: 'Other event types.', ordinal: 40 }
    ]
  end


  def down
    EventType.delete_all
  end
end
