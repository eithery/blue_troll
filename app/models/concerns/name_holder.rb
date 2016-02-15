# Eithery Lab, 2016.
# NameHolder concern.
# Provides name attribute related behavior and validation.

module NameHolder
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  end
end
