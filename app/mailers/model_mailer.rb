class ModelMailer < ApplicationMailer

  default from: "zeta@zeta.com.br"

  def new_record_notification(user)
    @user = user
    mail to: @user.email, subject: "Success! New user notification"
  end
end
