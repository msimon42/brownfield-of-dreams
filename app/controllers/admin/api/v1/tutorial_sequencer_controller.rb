superclass = Admin::Api::V1::BaseController
class Admin::Api::V1::TutorialSequencerController < superclass
  def update
    tutorial = Tutorial.find(params[:tutorial_id])
    TutorialSequencer.new(tutorial, ordered_video_ids).run!

    render json: tutorial
  end

  private

    def ordered_video_ids
      params[:tutorial_sequencer][:_json]
    end
end
