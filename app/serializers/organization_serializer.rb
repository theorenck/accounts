class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_one :owner
  has_many :service_instances
  has_many :members
end
