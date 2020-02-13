class WelcomeController < ApplicationController
  def index
    @tutorials = filter_tutorials
  end

  private

    def filter_tutorials
      if current_user
        tutorials.non_classroom
      else
        tutorials
      end
    end

    def tutorials
      if params[:tag]
        Tutorial
          .tagged_with(params[:tag])
          .paginate(page: params[:page], per_page: 5)
      else
        Tutorial.all.paginate(page: params[:page], per_page: 5)
      end
    end
end
