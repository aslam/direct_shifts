class Referral < ApplicationRecord
  belongs_to :inviter, class_name: 'User'

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validate :email_not_taken

  private

  def email_not_taken
    if User.exists?(email: email)
      errors.add(:email, 'is already taken by a registered user')
    end
  end
end
