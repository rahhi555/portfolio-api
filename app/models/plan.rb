class Plan < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy
  has_many :members, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
