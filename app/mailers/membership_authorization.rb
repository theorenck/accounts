class MembershipAuthorization < ApplicationMailer

  default from: "zeta@zeta.com.br"

  def new_membership_notification(membership)
    @membership = membership
    mail to: @membership.organization.owner.email, subject: "Success! New membership notification"
  end

  def authorized_notification(membership)
    @membership = membership
    mail to: @membership.user.email, subject: "Success! membership authorized"
  end

end
