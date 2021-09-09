class Svg < ApplicationRecord
  belongs_to :map

  attribute :fill, default: 'white'
  attribute :stroke, default: 'black'

  validates :x, presence: true
  validates :y, presence: true
  validates :fill, presence: true
  validates :stroke, presence: true
  validates :name, presence: true
end
