class ApplicationInstance < ActiveRecord::Base
  belongs_to :application
  has_and_belongs_to_many :organizations,  :join_table => :subscriptions
  has_many :authorizations

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :url,
        :version,
        :created_at,
        :updated_at
      ],
      include:[
        :application
      ]
    }.merge(options))
  end
end
