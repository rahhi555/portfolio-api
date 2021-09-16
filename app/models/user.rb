class User < ApplicationRecord
  has_many :plans, dependent: :nullify
  has_many :members, dependent: :destroy
  has_many :roles, through: :plans
  has_many :maps, through: :plans

  enum provider: { anonymous: 0, password: 1, google: 2 }

  has_one_attached :avatar

  validates :uid, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { maximum: 50 }

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.url_for(avatar) : nil
  end
end
