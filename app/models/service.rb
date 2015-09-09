class Service < ActiveRecord::Base
	belongs_to :service_type
	belongs_to :organization

	has_one :type, foreign_key: 'id', class_name: 'ServiceType', primary_key: 'type_id'


	def as_json(options={})
		{
			id: id,
			type: type,
			organization_id: organization_id,
			name: name,
			description: description,
			url: url,
			created_at: created_at,
			updated_at: updated_at
		}
	end

end
