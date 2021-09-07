FactoryBot.define do
  factory :member do
    user
    plan
    role { association :role, plan: plan }
    accept { false }
  end
end
