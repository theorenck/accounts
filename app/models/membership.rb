class Membership < ActiveRecord::Base

	belongs_to :organization
  belongs_to :user

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
