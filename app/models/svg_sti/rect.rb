class Rect < Svg
  validates :width, presence: true
  validates :height, presence: true
  validates :display_time, absence: true
  validates :draw_points, absence: true
end
