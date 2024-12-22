class UsersController < ApplicationController
  before_action :authenticate_user!

  def send_referral
    referral_email = params[:email]
    ReferralMailer.invite_email(referral_email, current_user).deliver_now
    render json: { message: 'Referral sent successfully' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
