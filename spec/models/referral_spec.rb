require 'rails_helper'

RSpec.describe Referral, type: :model do
  subject { build(:referral) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it 'validates that email is not taken by a registered user' do
      create(:user, email: subject.email)
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include('is already taken by a registered user')
    end
  end

  describe 'associations' do
    it { should belong_to(:inviter).class_name('User') }
  end
end
