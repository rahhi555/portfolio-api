FactoryBot.define do
  factory :role do
    plan
    sequence(:name, 'name_1')
  end
end
