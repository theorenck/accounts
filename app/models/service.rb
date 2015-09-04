class Service < ActiveRecord::Base
	belongs_to :service_type
	belongs_to :organization

	has_one :type, foreign_key: 'id', class_name: 'ServiceType', primary_key: 'type_id'
end
