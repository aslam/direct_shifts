class ReferralMailer < ApplicationMailer
  def invite_email(referral_email, inviter)
    @inviter = inviter
    mail(to: referral_email, subject: 'You are invited to join DirectShifts')
  end
end
