FactoryBot.define do
  factory :svg, class: 'Svg' do
    type { "" }
    map
    x { 30 }
    y { 30 }
    fill { "white" }
    stroke { "black" }
    name { "test svg" }
    width { 300 }
    height { 300 }
    display_time { 3000 }
    draw_points { "10 20 30 30 20" }
  end
end
