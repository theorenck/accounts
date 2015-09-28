class RetrievePassword < ApplicationMailer

  default from: "zeta@zeta.com.br"
  
  def retrieve_password_notification(user)
    @user = user
    mail to: @user.email, subject: "Success! Retrieved password notification"
  end
end
