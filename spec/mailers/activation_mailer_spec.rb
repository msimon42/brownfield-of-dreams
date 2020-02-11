require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  describe 'activation_email' do
    before(:each) do
      @user = create(:user)
      @email = described_class.activation_email(@user.email).deliver_now
    end

    it 'has a subject line' do
      expect(@email.subject).to eq("Activate your VideoField account")
    end

    it 'has the email of the user who created the account' do
      expect(@email.to).to eq(@user.email)
    end

    it 'has a body which invites user to click link to activate account' do
      expect(@email.body.encoded).to eq('Visit here to activate your account')
    end

    it 'has the from email of the overall site' do
      expect(@email.from).to eq('noreply@videofield.io')
    end

    it 'correctly interpolates the URL of the activation page' do
      expect(@email.body.encoded).to have_link('here', href: "localhost:3000/users/#{@user.id}/activate")
    end
  end
end
