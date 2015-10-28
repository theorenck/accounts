class Membership < ActiveRecord::Base
	after_create :request_activation_mail

	belongs_to :organization
  belongs_to :user

	has_many :authorizations

  validates :user, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
				:active,
				:integration,
        :created_at,
        :updated_at
      ]
    }.merge(options))
  end

	def request_activation_mail
		if self.user.id == self.organization.owner_id
			self.active = true
			self.save
		else
			MembershipActivation.new_membership_notification(self).deliver_now
		end
	end

	def activate
    self.active = true
    self.save
		MembershipActivation.activated_notification(self).deliver_now
  end

end
