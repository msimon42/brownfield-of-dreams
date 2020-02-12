require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe 'send_invite' do
    before(:each) do
      @user = create(:user)
      @invitee_data = { 'name' => 'John Doe', 'email' => 'johndoe@gmail.com' }
      @email = described_class.send_invite(@user, @invitee_data).deliver_now
    end

    it 'has a subject line' do
      expect(@email.subject).to eq("You're invited to VideoField!")
    end

    it 'was sent to the email of the user who was invited' do
      expect(@email.to).to eq([@invitee_data['email']])
    end

    it 'has the from email of the overall site' do
      expect(@email.from).to eq(['noreply@videofield.io'])
    end

    describe 'has a body which' do
      it 'greets the invitee by name' do
        expect(@email.body.encoded).to have_content('Hello John Doe,')
      end

      it 'says who the visitor was invited by' do
        expect(@email.body.encoded).to have_content("#{@user.name} has invited you to join VideoField.")
      end

      it 'invites user to click link to signup' do
        expect(@email.body.encoded).to have_content('You can create an account')
      end

      it 'has a link with full URL of the registration page' do
        expect(@email.body.encoded).to have_link('here', href: "http://localhost:3000/register")
      end
    end
  end
end
