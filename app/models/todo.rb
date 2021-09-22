class Todo < ApplicationRecord
  belongs_to :todo_list
  has_many_attached :images

  attribute :status, :integer, default: 0

  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title, presence: true, length: { maximum: 50 }
  validates :images, attachment: true

  def image_urls(*size)
    if images.attached?
      images.map do |image|
        resize_image = size.length == 2 ? image.variant(resize_to_limit: [size[0], size[1]]).processed : image
        Rails.application.routes.url_helpers.url_for(resize_image)
      end
    else
      nil
    end
  end
end
