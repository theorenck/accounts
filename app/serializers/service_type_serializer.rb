class ServiceTypeSerializer < ActiveModel::Serializer
  attributes :id, :code,:name,:description,:created_at,:updated_at
end
