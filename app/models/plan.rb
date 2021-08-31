class Plan < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
