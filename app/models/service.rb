class Service < ActiveRecord::Base

	belongs_to :service_type

	has_many :service_instances
  has_many :organizations, through: :service_instances

  has_one :type, foreign_key: 'id', class_name: 'ServiceType', primary_key: 'type_id'

  validates :version, presence: true
end
