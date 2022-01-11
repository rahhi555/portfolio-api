class Map < ApplicationRecord
  belongs_to :plan
  has_many :svgs, dependent: :destroy
  has_many :rects, dependent: :destroy
  has_many :paths, dependent: :destroy
  has_many :polylines, dependent: :destroy

  MAPS_SCHEMA = {
    type: 'object',
    properties: {
      north: { type: 'float' },
      east: { type: 'float' },
      south: { type: 'float' },
      west: { type: 'float' }
    },
  }.freeze

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true, scope: :plan_id }
  validates :bounds, json: { schema: MAPS_SCHEMA }, if: :bounds?
end
