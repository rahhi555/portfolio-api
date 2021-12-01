class Todo < ApplicationRecord
  belongs_to :todo_list
  has_many :todo_statuses, dependent: :destroy
  has_many_attached :images

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

  def strf_begin_time
    begin_time&.strftime('%H:%M')
  end

  def strf_end_time
    end_time&.strftime('%H:%M')
  end
end
