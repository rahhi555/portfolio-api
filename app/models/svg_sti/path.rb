class Path < Svg
  validates :width, absence: true
  validates :height, absence: true
  validates :draw_points, presence: true
end
