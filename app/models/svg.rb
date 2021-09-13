class Svg < ApplicationRecord
  belongs_to :map

  attribute :fill, default: 'white'
  attribute :stroke, default: 'black'

  before_create do
    self.display_order = map.svgs.count
  end

  validates :x, presence: true
  validates :y, presence: true
  validates :fill, presence: true
  validates :stroke, presence: true
  validates :name, presence: true
end
