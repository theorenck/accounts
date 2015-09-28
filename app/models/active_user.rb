class ActiveUser < ActiveType::Object

  attribute :activation_token,  :string

  def active
    begin
      @user = User.find_by(activation_token: self.activation_token)
      unless @user.activated?
        @user.active
      else
        false
      end
    rescue => ex
      false
    end
  end

end
