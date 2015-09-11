class ServiceInstance < ActiveRecord::Base
  belongs_to :service
  belongs_to :organization

  validates :url, :service, :organization, presence: true
  validates :url, uniqueness: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :url,
        :created_at,
        :updated_at,
      ],
      include:[
        :service
      ]
    }.merge(options))
  end
end
