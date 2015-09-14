class ApplicationInstance < ActiveRecord::Base

  has_and_belongs_to_many :organizations,  :join_table => :subscriptions
  has_many :authorizations

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :version,
        :code,
        :name,
        :description,
        :url,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end
end
