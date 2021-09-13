FactoryBot.define do
  factory :path, parent: :svg, class: 'Path' do
    type { 'Path' }
    width { nil }
    height { nil }
  end
end
