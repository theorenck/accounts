class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :type_id,:version,:created_at,:updated_at
end
