require 'rails_helper'

RSpec.describe 'User Authentication', type: :request do
  describe 'POST /users' do
    it 'creates a new user' do
      user_params = {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }

      post '/users', params: user_params

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /users/sign_in' do
    let(:user) { create(:user) }
    let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

    it 'logs in a user' do
      login_params = {
        user: {
          email: user.email,
          password: user.password
        }
      }

      post '/users/sign_in', params: login_params

      expect(response).to have_http_status(:ok)
      expect(response.headers['Authorization']).to be_present
    end
  end
end
