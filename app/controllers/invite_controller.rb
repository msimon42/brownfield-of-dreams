class InviteController < ApplicationController
  def new
  end

  def create
    token = current_user.token || ENV['GITHUB_TOKEN']
    data = GithubService.github_user_data_by_name(params[:github_handle], token)
    if data['email']
      # mailer call, send user and invitee
      # flash success message
    # else
      # flash error message
    # end
    redirect_to '/dashboard'
  end
end
