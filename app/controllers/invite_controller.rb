class InviteController < ApplicationController
  def index
  end

  def create
    user_data = GithubService.new.github_user_data(params[:github_handle], token)
    invitee = Invitee.new(user_data)
    if invitee.email
      InviteMailer.invite(current_user, invitee).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to '/dashboard'
  end

  private

    def token
      if current_user.github_token
        current_user.github_token
      else
        ENV['GITHUB_TOKEN']
      end
    end
end
