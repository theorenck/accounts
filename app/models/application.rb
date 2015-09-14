class Application < ActiveRecord::Base
  has_many :application_instances

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :code,
        :name,
        :description,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end
end
