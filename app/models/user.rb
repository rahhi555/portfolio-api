class User < ApplicationRecord
  has_many :plans, dependent: :nullify
  has_many :members, dependent: :destroy
  has_many :roles, through: :plans
  has_many :maps, through: :plans
  has_many :svgs, dependent: :nullify

  enum provider: { anonymous: 0, password: 1, google: 2 }

  has_one_attached :avatar

  validates :uid, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { maximum: 50 }
  validates :avatar, attachment: true

  def avatar_url(*size)
    if avatar.attached?
      resize_avatar = size.blank? ? avatar : avatar.variant(resize_to_limit: [size[0], size[1]]).processed
      Rails.application.routes.url_helpers.url_for(resize_avatar)
    else
      nil
    end
  end
end
