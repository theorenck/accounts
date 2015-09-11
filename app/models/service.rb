class Service < ActiveRecord::Base

  belongs_to :type, :class_name => 'ServiceType'

	has_many :instances, :class_name => 'ServiceInstance'
  has_many :organizations, through: :instances

  has_one :type, foreign_key: 'id', class_name: 'ServiceType', primary_key: 'type_id'

  validates :version, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :version,
        :created_at,
        :updated_at,
      ],
      include:[
        :type
      ]
    }.merge(options))
  end
end
