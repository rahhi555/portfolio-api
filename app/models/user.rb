class User < ApplicationRecord
  has_many :plans, dependent: :nullify

  enum provider: { 'anonymous': 0, 'password': 1, 'google': 2 }

  validates :uid, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { maximum: 50 }
end
