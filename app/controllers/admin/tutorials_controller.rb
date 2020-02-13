class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(new_tutorial_params)
    if @tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to "/tutorials/#{@tutorial.id}"
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      redirect_to '/admin/tutorials/new'
    end
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

    def tutorial_params
      params.require(:tutorial).permit(:tag_list)
    end

    def new_tutorial_params
      params.require(:tutorial).permit(:title, :description, :thumbnail)
    end
end
