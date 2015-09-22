class ModelMailer < ApplicationMailer

  default from: "zeta@zeta.com.br"

  def new_record_notification(user)
    mail to: user, subject: "Success! You did it."
  end

end
