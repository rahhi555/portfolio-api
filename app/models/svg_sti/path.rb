class Path < Svg
  attribute :display_time, default: 3000

  validates :width, absence: true
  validates :height, absence: true
  validates :display_time, presence: true
  validates :draw_points, presence: true
end
