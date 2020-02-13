require 'rails_helper'

RSpec.describe 'As an admin' do
  before(:each) do
    @admin_user = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  describe "When I visit '/admin/tutorials/new'" do
    before(:each) do
      visit '/admin/tutorials/new'
    end

    describe 'And I fill in fields correctly and click Save' do
      before(:each) do
        fill_in 'Title', with: 'How to Tie Shoes'
        fill_in 'Description', with: 'An important lesson for burgeoning devs.'
        fill_in 'Thumbnail', with: 'http://i3.ytimg.com/vi/TqPCGGHoxsE/hqdefault.jpg'

        click_on 'Save'
      end

      it "Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'" do
        expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
      end

      it 'And I should see a flash message that says "Successfully created tutorial."' do
        expect(page).to have_content('Successfully created tutorial.')
      end
    end

    describe 'And I fill in form incorrectly' do
      describe 'by not providing title' do
        before(:each) do
          fill_in 'Description', with: 'An important lesson for burgeoning devs.'
          fill_in 'Thumbnail', with: 'http://i3.ytimg.com/vi/TqPCGGHoxsE/hqdefault.jpg'

          click_on 'Save'
        end

        it 'I should remain on the form page' do
          expect(current_path).to eq('/admin/tutorials/new')
        end

        it 'I should see a flash message with error' do
          expect(page).to have_content("Title can't be blank")
        end
      end

      describe 'by not providing description' do
        before(:each) do
          fill_in 'Title', with: 'How to Tie Shoes'
          fill_in 'Thumbnail', with: 'http://i3.ytimg.com/vi/TqPCGGHoxsE/hqdefault.jpg'

          click_on 'Save'
        end

        it 'I should remain on the form page' do
          expect(current_path).to eq('/admin/tutorials/new')
        end

        it 'I should see a flash message with error' do
          expect(page).to have_content("Description can't be blank")
        end
      end

      describe 'by not providing thumbnail' do
        before(:each) do
          fill_in 'Title', with: 'How to Tie Shoes'
          fill_in 'Description', with: 'An important lesson for burgeoning devs.'

          click_on 'Save'
        end

        it 'I should remain on the form page' do
          expect(current_path).to eq('/admin/tutorials/new')
        end

        it 'I should see a flash message with error' do
          expect(page).to have_content("Thumbnail can't be blank")
        end
      end
    end
  end
end
