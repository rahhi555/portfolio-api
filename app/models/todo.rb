class Todo < ApplicationRecord
  belongs_to :todo_list
  has_many_attached :images

  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title, presence: true, length: { maximum: 50 }
  validates :images, attachment: true

  def image_urls
    if images.attached?
      images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
    else
      nil
    end
  end
end
