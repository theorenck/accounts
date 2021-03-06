class Organization < ActiveRecord::Base

	has_many :memberships
  has_many :service_instances

  has_many :members, :through => :memberships, :source => :user
  has_many :services, :through =>  :service_instances

  has_one :profile, as: :profileable
  has_one :owner, foreign_key: 'id', class_name: 'User', primary_key: 'owner_id'

	has_and_belongs_to_many :applications,  :join_table => :subscriptions

  accepts_nested_attributes_for :memberships

  validates :name, presence: true

  def serializable_hash(options = {})
    super({
      only:[
				:id,
        :name,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end

	def owned_by(id)
		true ? self.owner_id == id : false
	end

	def find_service(version, code)
		self.service_instances.joins(service: [:type]).where(services: {version: version}, service_types: {code: code}).first
	end
end
