class Member < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :role, optional: true

  validates :user_id, uniqueness: { scope: :plan_id }
  validates :accept, inclusion: { in: [true, false] }
  validate :role_include_plan?

  private

  def role_include_plan?
    return if plan.nil? || role_id.nil?

    plan.reload
    errors.add(:role, 'do not exist in the plan') unless plan.role_ids.include?(role_id)
  end
end
