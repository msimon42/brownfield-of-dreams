require 'rails_helper'

RSpec.describe 'when i visit the tutorial show' do
  describe 'and the tutorial has no videos' do
    before :each do
      @tutorial = create :tutorial
    end

    it 'the page still works' do
      visit tutorial_path(@tutorial.id)

      expect(page).to have_content('This tutorial has no videos')
    end
  end
end
