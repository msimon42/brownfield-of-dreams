RSpec.describe 'as a visitor' do
  it 'can visit get started page' do
    visit '/get_started'

    expect(current_path).to eq('/get_started')
  end
end
