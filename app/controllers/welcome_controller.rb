class WelcomeController < ApplicationController
  def index
    @tutorials = filter_tutorials
  end

  private

    def filter_tutorials
      case current_user
      when nil
        return Tutorial.non_classroom.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) if params[:tag]
        return Tutorial.non_classroom.paginate(page: params[:page], per_page: 5)
      else
        return Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5) if params[:tag]
        return Tutorial.all.paginate(page: params[:page], per_page: 5)
      end
    end
end
