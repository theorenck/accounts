class User < ActiveRecord::Base

  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :profiles, as: :profileable

	before_create :set_token


  private
    def set_token
      return if token.present?
      self.token = generate_token
    end

    def generate_token
      loop do
        token = SecureRandom.hex
        break token unless self.class.exists?(token: token)
      end
    end

end
