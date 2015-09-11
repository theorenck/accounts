class UserSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :current_sign_in_ip, :updated_at, :created_at

  has_many :memberships
  has_many :organizations

  def current_sign_in_ip
    object.current_sign_in_ip.to_s
  end

end
