class ActivationMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Activate your VideoField account')
  end
end
