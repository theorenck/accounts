class Authorization < ActiveRecord::Base
  belongs_to :membership
  belongs_to :application

  has_one :user, :through => :membership
  has_one :organization, :through => :membership

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :scopes,
        :created_at,
        :updated_at
      ],
      include:[
        :application,
        :organization
      ]
    }.merge(options))
  end
end
