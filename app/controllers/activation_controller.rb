class ActivationController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user.update(active: true)
    redirect_to "/users/#{user.id}/activated"
  end

  def show
    @user = User.find(params[:user_id])
  end
end
