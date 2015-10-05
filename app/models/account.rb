class Account < ActiveRecord::Base

  # def as_json(options={})
  #   {
  #     user: {
  #       id: user_id,
  #       username: username,
  #       email: email
  #     },
  #     organization_id: organization_id,
  #     application_id: application_id,
  #     authorization_id: authorization_id
  # }
  # end

  # def serializable_hash(options = {})
  #   super({
  #     only:[
  #       # :username
  #     ]
  #   }.merge(options))
  # end

end
