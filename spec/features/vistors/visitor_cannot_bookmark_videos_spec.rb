require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I click the bookmark button on a video page' do
    before(:each) do
      visit '/tutorials/1?video_id=1'

      click_on 'Bookmark'
    end

    it 'I remain on the page' do
      expect(current_path).to eq('/tutorials/1?video_id=1')
    end

    it 'I see a flash message alerting me that I need to be logged in' do
      expect(page).to have_content("You must be logged in to bookmark videos.")
    end
  end
end
