require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click the bookmark button on a video page' do
    before(:each) do
      @tutorial = create(:tutorial)
      @video = create(:video, tutorial: @tutorial)
      visit tutorial_path(@tutorial, video_id: @video.id)

      click_on 'Bookmark'
    end

    it 'I remain on the page' do
      expect(page).to have_current_path(tutorial_path(@tutorial, video_id: @video.id))
    end

    it 'I see a flash message alerting me that I need to be logged in' do
      expect(page).to have_content("You must be logged in to bookmark videos.")
    end
  end
end
