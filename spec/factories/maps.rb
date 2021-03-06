FactoryBot.define do
  factory :map do
    plan
    sequence(:name, 'map_1')
    is_google_map { false }
    address { nil }
    bounds { nil }
    height { nil }
    width { nil }

    trait :use_google_map do
      is_google_map { true }
      address { '東京都千代田区丸の内１丁目９ JR 東京駅' }
      bounds { { north: 36.164233296653045, south: 36.16299249843693, east: 140.37886504843758, west: 140.3772721515624 } }
      height { 700 }
      width { 1800 }
    end

    # 境界値テスト用
    trait :valid_under_boundary do
      bounds { { north: -90, south: -90, east: -180, west: -180 } }
    end

    trait :invalid_under_boundary do
      bounds { { north: -91, south: -91, east: -181, west: -181 } }
    end

    trait :valid_upper_boundary do
      bounds { { north: 90, south: 90, east: 180, west: 180 } }
    end

    trait :invalid_upper_boundary do
      bounds { { north: 91, south: 91, east: 181, west: 181 } }
    end

    # boundsのキーが多いor少ない
    trait :over_bounds_key do
      bounds { { north: 0, south: 0, east: 0, west: 0, dummy: 0 } }
    end

    trait :less_bounds_key do
      bounds { { north: 0, south: 0, east: 0 } }
    end
  end
end
