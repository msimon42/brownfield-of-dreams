class InviteMailer < ApplicationMailer
  def send_invite(user, invitee_data)
    @user = user
    @invitee_data = invitee_data
    mail(to: @invitee_data['email'], subject: "You're invited to VideoField!")
  end
end
