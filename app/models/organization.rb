class Organization < ActiveRecord::Base

	has_many :memberships
  has_many :users, through: :memberships
  has_many :profiles, as: :profileable
  has_many :service_instances
  has_many :services, through: :service_instances

  has_one :owner, foreign_key: 'id', class_name: 'User', primary_key: 'owner_id'

  accepts_nested_attributes_for :memberships

  # def as_json(options={})
  #   {
  #     id: id,
  #     owner: owner,
  #     name: name,
  #     services: services,
  #     members: users,
  #     created_at: created_at,
  #     updated_at: updated_at
  #   }
  # end

end
