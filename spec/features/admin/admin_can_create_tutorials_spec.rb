require 'rails_helper'

RSpec.describe 'As an admin' do
  before(:each) do
    @admin_user = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    Tutorial.destroy_all
  end

  describe "When I visit '/admin/tutorials/new'" do
    before(:each) do
      visit '/admin/tutorials/new'
    end

    describe 'And I fill in fields correctly and click Save' do
      before(:each) do
        fill_in 'name', with: 'How to Tie Shoes'
        fill_in 'description', with: 'An important lesson for burgeoning devs.'
        fill_in 'thumbnail', with: 'http://i3.ytimg.com/vi/TqPCGGHoxsE/hqdefault.jpg'

        click_on 'Save'
      end

      it "Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'" do
        expect(current_path).to eq('/tutorials/1')
      end

      it 'And I should see a flash message that says "Successfully created tutorial."' do
        expect(page).to have_content('Successfully created tutorial.')
      end
    end
  end
end
