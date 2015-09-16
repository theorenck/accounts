class SignIn < ActiveType::Object

  after_validation :retrive_user

  attribute :username,  :string
  attribute :password,  :string
  attribute :remote_ip, :string

  validates :username, presence: true
  validates :password, presence: true

  def retrive_user
    @user = User.find_by(username: self.username, password: self.password)
    @user.update_sign_in_info(self.remote_ip)
  end

  def token
    @user.token
  end

  def as_json(options = {})
    { token: token }
  end
end
