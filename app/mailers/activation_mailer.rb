class ActivationMailer < ApplicationMailer
  def activation_link(user)
    @user = user
    mail(to: @user.email, subject: 'Activate Your New Account')
  end
end
