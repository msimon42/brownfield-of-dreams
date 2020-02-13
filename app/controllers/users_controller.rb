class UsersController < ApplicationController
  def show
    @user = User.where(id: current_user.id).includes(videos: :tutorial).first
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      ActivationMailer.activation_email(user).deliver_now
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_back fallback_location: register_path
    end
  end

  def update
    current_user.update(github_id: new_github_id,
                        github_token: new_github_token)
    redirect_to '/dashboard'
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

    def new_github_id
      return unless request.env['omniauth.auth']

      request.env['omniauth.auth']['uid']
    end

    def new_github_token
      return unless request.env['omniauth.auth']

      request.env['omniauth.auth']['credentials']['token']
    end
end
