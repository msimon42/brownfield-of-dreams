require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe 'I cannot see tutorials when i log in' do
    before :each do
      @tutorial_1 = create :tutorial
      @tutorial_2 = create :tutorial, classroom: true

      it 'does non show the second tutorial' do
        visit root_path

        expect(page).to have_link(@tutorial_1.title)
        expect(page).to have_content(@tutorial_1.description)

        expect(page).to_not have_content(@tutorial_2.title)
        expect(page).to_not have_content(@tutorial_2.description)
      end
    end
  end
end
