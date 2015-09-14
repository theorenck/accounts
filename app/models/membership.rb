class Membership < ActiveRecord::Base

	belongs_to :organization
  belongs_to :user

	has_many :authorizations

 	has_one :integration, class_name: 'LegacyIntegration'

  validates :user, :organization, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end
end
