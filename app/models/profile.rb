class Profile < ActiveRecord::Base

	belongs_to :profileable, polymorphic: true

  validates :version, presence: true
end
