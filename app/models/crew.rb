class Crew < ActiveRecord::Base
  validates :name, :native_name, presence: true, uniqueness: true

  has_many :participants

  def to_s
  	name
  end

  def to_file_name
    name.gsub(/\s/, '_').downcase
  end
end
