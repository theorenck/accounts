class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :current_sign_in_ip, :updated_at, :created_at

  def current_sign_in_ip
    object.current_sign_in_ip.to_s
  end

end
