class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name#, :owner, services, members,
end
