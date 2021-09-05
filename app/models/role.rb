class Role < ApplicationRecord
  belongs_to :plan
  has_many :members, dependent: :nullify

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true, scope: :plan }
end
