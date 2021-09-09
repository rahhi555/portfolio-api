FactoryBot.define do
  factory :svg, class: 'Svg' do
    type { "" }
    map
    x { 1.5 }
    y { 1.5 }
    fill { "MyString" }
    stroke { "MyString" }
    name { "MyString" }
    width { 1.5 }
    height { 1.5 }
    display_time { 3000 }
    draw_points { "MyText" }
  end
end
