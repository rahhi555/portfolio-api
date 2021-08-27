FactoryBot.define do
  factory :plan do
    sequence(:name, 'plan_1')
    user
  end
end
