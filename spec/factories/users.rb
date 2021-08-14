FactoryBot.define do
  factory :user do
    sequence(:name, 'user_1')
    uid { SecureRandom.uuid }
  end
end
