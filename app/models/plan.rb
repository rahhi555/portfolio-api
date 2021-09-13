class Plan < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :svgs,  -> { select 'svgs.*, plan_id' }, through: :maps

  validates :name, presence: true, length: { maximum: 50 }
end
