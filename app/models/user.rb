class User < ApplicationRecord
  has_many :plans, dependent: :nullify

  validates :uid, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { maximum: 50 }
end
