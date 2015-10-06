class Membership < ActiveRecord::Base
	after_create :request_authorization_mail

	belongs_to :organization
  belongs_to :user

	has_many :authorizations

  validates :user, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
				:authorized,
				:legacy_integration,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end

	def request_authorization_mail
		MembershipAuthorization.new_membership_notification(self).deliver_now
	end

	def authorize
    self.authorized = true
    self.save
		MembershipAuthorization.authorized_notification(self).deliver_now
  end

end
