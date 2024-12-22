FactoryBot.define do
  factory :referral do
    email { Faker::Internet.email }
    association :inviter, factory: :user
  end
end
