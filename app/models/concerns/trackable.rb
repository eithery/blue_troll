# Eithery Lab, 2016.
# Trackable concern.
# Adds trackable behavior to a model.

module Trackable
  extend ActiveSupport::Concern

  included do
    validates :created_by, :updated_by, presence: true
  end
end
