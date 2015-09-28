class User < ActiveRecord::Base

  before_create :set_token
  after_create :send_activation_mail

  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :authorizations, through: :memberships
  has_one :profile, as: :profileable

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :username, length: { in: 6..20 }
  validates :email, length: { in: 6..60 }
  # validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: "must be at least 6 characters and include one number and one letter."}

  def serializable_hash(options = {})
    super({
      only:[
        :id,
        :username,
        :email,
        :created_at,
        :updated_at,
      ]
    }.merge(options))
  end

  def update_sign_in_info(remote_ip)
    self.last_sign_in_ip = current_sign_in_ip
    self.last_sign_in_at = current_sign_in_at
    self.current_sign_in_ip = remote_ip
    self.current_sign_in_at = Time.new
    self.save
  end

  def activation_url
    "http://127.0.0.1:3000/api/v1/users/activation?activation_token="+self.activation_token.to_s
  end

  def active
    self.activated = true
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

    def send_activation_mail
      self.activation_token = SecureRandom.hex
      self.save
      ModelMailer.new_record_notification(self).deliver_now
    end

end
