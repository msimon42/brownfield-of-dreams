class InviteController < ApplicationController
  def new; end

  def create
    if create_data['email']
      InviteMailer.send_invite(current_user, create_data).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email
                      address associated with their account."
    end
    redirect_to '/dashboard'
  end

  private

    def token
      current_user.github_token || ENV['GITHUB_TOKEN']
    end

    def create_data
      GithubService.new.github_user_data_by_name(params[:github_handle], token)
    end
end
