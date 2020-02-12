require 'rails_helper'

RSpec.describe 'User activation process', :vcr, type: :feature do
  describe 'As a non-activated user' do
    describe 'When I follow the link in the account activation email' do
      before(:each) do
        @user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit "/users/#{@user.id}/activate"
      end

      it "then I should be taken to a page that says 'Thank you! Your account is now activated.'" do
        expect(current_path).to eq("/users/#{@user.id}/activated")
        expect(page).to have_content('Thank you! Your account is now activated.')
        expect(page).not_to have_content('We had a problem verifying your account.')
      end
    end
  end

  describe 'As an activated user' do
    describe 'when I visit the dashboard' do
      before(:each) do
        @user = create(:user, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit '/dashboard'
      end

      it 'Then I should see "Status: Active"' do
        expect(page).to have_content("Status: Active")
        expect(page).not_to have_content("This account has not yet been activated. Please check your email.")
      end
    end
  end
end
