class PasswordRetrieval < ActiveType::Object

  attribute :email,  :string

  def retrieve

    begin
      @user =  User.find_by(email: self.email)
      @user.password = SecureRandom.hex(4)
      @user.last_password_retrieval_at = Time.new
      @user.save
      UserMailer.retrieve_password_notification(@user).deliver_now
    rescue => ex
      false
    end

  end

end
