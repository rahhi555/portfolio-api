class Svg < ApplicationRecord
  belongs_to :map
  belongs_to :todo_list, optional: true
  belongs_to :user, -> { includes(avatar_attachment: :blob) }, optional: true
  has_many :todo_statuses, dependent: :destroy

  attribute :fill, default: 'white'
  attribute :stroke, default: 'black'

  before_create do
    self.display_order = map.svgs.maximum(:display_order).to_i + 1
  end

  validates :x, presence: true
  validates :y, presence: true
  validates :fill, presence: true
  validates :stroke, presence: true
  validates :name, presence: true
end
