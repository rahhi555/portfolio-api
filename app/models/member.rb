class Member < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :role, optional: true

  validates :user_id, uniqueness: { scope: :plan_id }
  validates :accept, inclusion: { in: [true, false] }
  validate :role_include_plan?
  # 作成者のacceptは変更できない
  validate :author_cant_change_accept, on: :update, if: -> { author? }

  # メンバー参加者が作成者本人か判定
  def author?
    user.id == plan.user.id
  end

  # メンバー参加者が作成者本人ならacceptはtrueになる
  # plansのcreateで作成される都合上、コントローラーではなくコールバックで定義する
  before_create do
    self.accept = true if author?
  end

  private

  def role_include_plan?
    return if plan.nil? || role_id.nil?

    plan.reload
    errors.add(:role, 'do not exist in the plan') unless plan.role_ids.include?(role_id)
  end

  def author_cant_change_accept
    raise ActiveRecord::RecordInvalid if will_save_change_to_accept?
  end
end
