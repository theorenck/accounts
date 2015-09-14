class Authorization < ActiveRecord::Base
  belongs_to :membership
  belongs_to :application_instance

  has_one :user, :through => :membership
  has_one :organization, :through => :membership

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :created_at,
        :updated_at
      ],
      include:[
        :application_instance,
        :organization
      ]
    }.merge(options))
  end
end
