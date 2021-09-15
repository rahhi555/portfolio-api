class Map < ApplicationRecord
  belongs_to :plan
  has_many :svgs, dependent: :destroy
  has_many :rects, dependent: :destroy
  has_many :paths, dependent: :destroy
  has_many :polylines, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true, scope: :plan_id }

  def next_display_order
    svgs.maximum(:display_order).to_i + 1
  end
end
