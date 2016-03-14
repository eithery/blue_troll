# Eithery Lab, 2016.
# ApplcationRecord model.
# Represents a base abstract class for all domain models.

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
