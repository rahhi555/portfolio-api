class Map < ApplicationRecord
  belongs_to :plan

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true, scope: :plan_id }
end
