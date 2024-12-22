# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource
      token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first
      render json: {
        message: 'Signed in successfully',
        user: current_user.as_json(except: :jti),
        token: token
      }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      render json: { errors: ['Failed to sign out'] }, status: :unprocessable_entity
    end
  end

  def verify_signed_out_user
    super
  end
end
