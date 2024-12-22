class ReferralsController < ApplicationController
  before_action :authenticate_user!

  def create
    referral_email = params[:referral_email]
    inviter = current_user

    if User.exists?(email: referral_email)
      render json: { errors: ['User with this email already exists'] }, status: :unprocessable_entity
      return
    end

    if Referral.exists?(email: referral_email)
      render json: { errors: ['Referral already sent to this email'] }, status: :unprocessable_entity
      return
    end

    referral = Referral.new(email: referral_email, inviter: inviter)
    if referral.save
      ReferralMailer.invite_email(referral_email, inviter).deliver_now
      render json: { message: 'Referral email sent successfully' }, status: :ok
    else
      render json: { errors: referral.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
