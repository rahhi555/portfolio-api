FactoryBot.define do
  factory :polyline, parent: :svg, class: 'Polyline' do
    type { 'Polyline' }
    width { nil }
    height { nil }
  end
end
