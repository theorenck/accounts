class ServiceInstance < ActiveRecord::Base
  belongs_to :service
  belongs_to :organization

  validates :uri, :service, :organization, presence: true
  validates :uri, uniqueness: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :uri,
        :created_at,
        :updated_at,
      ],
      include:[
        :service
      ]
    }.merge(options))
  end
end
