FactoryBot.define do
  factory :plan do
    sequence(:name, 'plan_1')
    user
    published { false }
  end
end
