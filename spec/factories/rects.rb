FactoryBot.define do
  factory :rect, parent: :svg, class: 'Rect' do
    type { 'Rect' }
    display_time { nil }
    draw_points { nil }
  end
end
