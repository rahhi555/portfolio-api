class TodoList < ApplicationRecord
  belongs_to :plan
  has_many :svgs, dependent: :nullify

  validates :title, presence: true, length: { maximum: 255 }
end
