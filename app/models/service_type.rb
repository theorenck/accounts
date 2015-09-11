class ServiceType < ActiveRecord::Base
	has_many :services, foreign_key: 'type_id'

  validates :code, :name, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :code,
        :name,
        :description,
        :created_at,
        :updated_at,
      ]
    }.merge(options))
  end
end
