class InviteMailer < ApplicationMailer
  def invite(user, invitee)
    @user = user
    @invitee = invitee
    mail(to: @invitee.email, subject: "You've been invited to VideoField!")
  end
end
