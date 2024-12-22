require 'rails_helper'

RSpec.describe "Referrals", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { referral_email: 'newuser@example.com' } }
  let(:invalid_attributes) { { referral_email: '' } }
  let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

  before do
    post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
    @token = JSON.parse(response.body)['token']
    headers['Authorization'] = "Bearer #{@token}"
  end

  describe 'POST /referrals' do
    context 'with valid parameters' do
      it 'creates a new Referral' do
        expect {
          post referrals_path, params: valid_attributes, headers: headers, as: :json
        }.to change(Referral, :count).by(1)
      end

      it 'sends a referral email' do
        expect {
          post referrals_path, params: valid_attributes, headers: headers, as: :json
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'renders a JSON response with the new referral' do
        post referrals_path, params: valid_attributes, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['message']).to eq('Referral email sent successfully')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Referral' do
        expect {
          post referrals_path, params: invalid_attributes, headers: headers, as: :json
        }.to change(Referral, :count).by(0)
      end

      it 'renders a JSON response with errors for the new referral' do
        post referrals_path, params: invalid_attributes, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        errors = JSON.parse(response.body)['errors']
        expect(errors).to include("Email can't be blank")
        expect(errors).to include("Email is invalid")
      end
    end

    context 'when user already exists' do
      let!(:existing_user) { create(:user, email: 'existinguser@example.com') }
      let(:existing_user_attributes) { { referral_email: 'existinguser@example.com' } }

      it 'does not create a new Referral' do
        expect {
          post referrals_path, params: existing_user_attributes, headers: headers, as: :json
        }.to change(Referral, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post referrals_path, params: existing_user_attributes, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        errors = JSON.parse(response.body)['errors']
        expect(errors).to include('User with this email already exists')
      end
    end

    context 'when referral already sent' do
      let!(:existing_referral) { create(:referral, email: 'referreduser@example.com', inviter: user) }
      let(:existing_referral_attributes) { { referral_email: 'referreduser@example.com' } }

      it 'does not create a new Referral' do
        expect {
          post referrals_path, params: existing_referral_attributes, headers: headers, as: :json
        }.to change(Referral, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post referrals_path, params: existing_referral_attributes, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        errors = JSON.parse(response.body)['errors']
        expect(errors).to include('Referral already sent to this email')
      end
    end
  end
end
