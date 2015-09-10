class ServiceType < ActiveRecord::Base
	has_many :services

  validates :code, :name, presence: true
end
