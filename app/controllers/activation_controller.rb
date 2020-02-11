class ActivationController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user.update(activated: true)
    redirect_to "/users/#{user.id}/activated"
  end
end
