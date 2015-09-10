class User < ActiveRecord::Base

  before_create :set_token

  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :profiles, as: :profileable

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  def as_json(options={})
    {
      id: id,
      username: username,
      email: email,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  def update_sign_in_info(remote_ip)
    self.last_sign_in_ip = current_sign_in_ip
    self.current_sign_in_ip = remote_ip

    self.last_sign_in_at = current_sign_in_at
    self.current_sign_in_at = Time.new

    self.save
  end

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
