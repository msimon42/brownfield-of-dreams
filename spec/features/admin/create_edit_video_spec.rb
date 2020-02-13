require 'rails_helper'

RSpec.describe 'videos' do
  before :each do
    @tutorial = create :tutorial
    @admin = create :admin
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  describe 'create video' do

    it 'will fail to create if missing info' do

      visit edit_admin_tutorial_path(@tutorial)

      click_on "Add Video"

      fill_in "video[title]", with: "How to tie your shoes."
      fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
      click_on "Create Video"

      expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))
      expect(page).to have_content("Unable to create video")
    end
  end
end
