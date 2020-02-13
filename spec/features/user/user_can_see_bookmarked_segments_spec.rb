require 'rails_helper'

feature 'As a logged in user', :vcr do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  feature "When I visit '/dashboard' and I have bookmarked segments" do
    before(:each) do
      @tutorial_1 = create(:tutorial)
      @tutorial_2 = create(:tutorial)
      @tutorial_3 = create(:tutorial)
      @video_1 = create(:video, tutorial: @tutorial_1, position: 1)
      @video_2 = create(:video, tutorial: @tutorial_2)
      @video_3 = create(:video, tutorial: @tutorial_1)
      @video_4 = create(:video, tutorial: @tutorial_3) # not bookmarked
      @user.videos << [@video_1, @video_2, @video_3]

      visit '/dashboard'
    end

    it 'Then I should see a list of all bookmarked segments under the Bookmarked Segments section' do
      within '.bookmarked' do
        expect(page).to have_content(@video_1.title)
        expect(page).to have_content(@video_2.title)
        expect(page).to have_content(@video_3.title)
        expect(page).not_to have_content(@video_4.title)
      end
    end

    it 'And they should be organized by which tutorial they are a part of' do
      within ".bookmarked" do
        expect(page.body.index(@video_3.title)).to be < page.body.index(@video_2.title)
        expect(page.body.index(@video_1.title)).to be < page.body.index(@video_2.title)
      end
    end

    it 'And the videos should be ordered by their position' do
      within ".bookmarked" do
        expect(page.body.index(@video_3.title)).to be < page.body.index(@video_1.title)
      end
    end
  end
end
