class Role < ApplicationRecord
  belongs_to :plan

  validates :name, presence: true, length: { maximum: 50 }
end
