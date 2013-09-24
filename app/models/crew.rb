class Crew < ActiveRecord::Base
  validates :name, :native_name, presence: true, uniqueness: true

  has_many :participants

  def to_s
  	name
  end

  def to_file_name
    name.gsub(/\s/, '_').downcase
  end


  def count
    participants.to_a.count
  end


  def adults
    participants.to_a.count { |p| p.category == :adult }
  end


  def children
    participants.to_a.count { |p| p.category == :child }
  end


  def babies
    participants.to_a.count { |p| p.category == :baby }
  end
end
