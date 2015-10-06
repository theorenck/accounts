class Membership < ActiveRecord::Base
	after_create :request_authorization_mail

  store_accessor :legacy_integrations
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

end
