require 'rails_helper'

RSpec.describe 'Referrals', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) do
    post '/users/sign_in', params: { user: { email: user.email, password: 'password123' } }
    { 'Authorization' => response.headers['Authorization'] }
  end

  describe 'POST /users/send_referral' do
    it 'sends a referral email' do
      referral_params = { email: 'friend@example.com' }

      post '/users/send_referral', params: referral_params, headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Referral sent successfully')

      # Check that one email was sent
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      # Inspect the email
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to include('friend@example.com')
      expect(email.subject).to eq('You are invited to join DirectShifts')
      expect(email.body.encoded).to include('Join Now')
    end
  end
end
