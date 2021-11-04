FactoryBot.define do
  factory :map do
    plan
    sequence(:name, 'map_1')
    is_google_map { false }
    address { nil }
    lat { nil }
    lng { nil }
    zoom { nil }

    trait :use_google_map do
      is_google_map { true }
      address { '〒100-0005 東京都千代田区丸の内１丁目９ JR 東京駅' }
      lat { 35.68146276355398 }
      lng { 139.76713552670145 }
      zoom { 18 }
    end
  end
end
