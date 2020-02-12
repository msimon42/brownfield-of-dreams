require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'non_classroom' do
      @tutorial_1 = create :tutorial
      @tutorial_4 = create :tutorial
      @tutorial_2 = create :tutorial, classroom: true
      @tutorial_3 = create :tutorial, classroom: true

      expect(Tutorial.non_classroom).to eq([@tutorial_1, @tutorial_4])
    end
  end
end
