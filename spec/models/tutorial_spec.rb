require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it {should have_many(:videos).dependent(:destroy)}
  end

  describe 'class methods' do
    it 'non_classroom' do
      tutorial_1 = create :tutorial
      tutorial_4 = create :tutorial
      tutorial_2 = create :tutorial, classroom: true
      tutorial_3 = create :tutorial, classroom: true

      expect(Tutorial.non_classroom).to eq([tutorial_1, tutorial_4])
    end
  end

  describe 'instance_methods' do
    it 'videos?' do
      tutorial_1 = create :tutorial
      tutorial_2 = create :tutorial
      create :video, tutorial: tutorial_1

      expect(tutorial_1.videos?).to be true 
      expect(tutorial_2.videos?).to be false
    end
  end
end
