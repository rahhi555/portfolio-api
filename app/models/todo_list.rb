class TodoList < ApplicationRecord
  belongs_to :plan
  has_many :svgs, dependent: :nullify
  has_many :todos, -> { includes(images_attachments: :blob) }, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
