# Eithery Lab, 2016.
# Rails migration helper.
# Extends Rails migration functionality introducing new column type helpers.

class ActiveRecord::ConnectionAdapters::TableDefinition
  def full_timestamps(*args)
    timestamps null: false
    string :created_by, null: false
    string :updated_by, null: false
  end
end
