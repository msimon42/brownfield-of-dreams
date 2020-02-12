require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it {should validate_presence_of :position}
  end
end
