class Membership < ActiveRecord::Base
	after_create :request_authorization_mail

	belongs_to :organization
  belongs_to :user

	has_many :authorizations

 	has_one :integration, class_name: 'LegacyIntegration'

  validates :user, presence: true
	# validates :organization, presence: true

  def serializable_hash(options = {})
    super({
      only:[
        :id,
				:authorized,
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

	def self.find_my(authorized, authenticated_id)
		if authorized
      Membership.joins(:organization).where(authorized: authorized, :organizations => {:owner_id => authenticated_id })
    else
      Membership.joins(:organization).where(:organizations => {:owner_id => authenticated_id })
    end
	end
end
