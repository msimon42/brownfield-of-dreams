require 'rails_helper'

RSpec.describe 'As a registered user' do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit /dashboard and click "Send an Invite"' do
    before(:each) do
      visit '/dashboard'

      click_on 'Send an Invite'
    end

    it 'Then I should be on /invite' do
      expect(current_path).to eq('/invite')
    end

    describe 'And when I fill in "Github Handle" with valid username of person with public email and click "Send Invite"' do
      before(:each) do
        fill_in 'Github Handle', with: 'DanielEFrampton'

        click_on 'Send Invite'
      end

      it 'Then I should be on /dashboard' do
        expect(current_path).to eq('/dashboard')
      end

      it 'And I should see a message that says "Successfully sent invite!"' do
        expect(page).to have_content("Successfully sent invite!")
      end
    end

    describe 'And when I fill in "Github Handle" with valid username of person with public email and click "Send Invite"' do
      before(:each) do
        fill_in 'Github Handle', with: 'mtsimon'

        click_on 'Send Invite'
      end

      it 'Then I should be on /dashboard' do
        expect(current_path).to eq('/dashboard')
      end

      it 'I should see a message that says "The Github user you selected doesn\'t have an email address associated with their account."' do
        expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
      end
    end
  end
end
