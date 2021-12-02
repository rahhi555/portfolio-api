class Plan < ApplicationRecord
  belongs_to :user
  has_many :roles, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :svgs, -> { select 'svgs.*, plan_id' }, through: :maps
  has_many :todo_lists, dependent: :destroy
  has_many :todos, through: :todo_lists
  has_many :todo_statuses, through: :svgs

  validates :name, presence: true, length: { maximum: 50 }

  # activeをtrueに更新し、TodoStatusにsvgとtodoのペアを流し込む
  def activate
    update!(active: true)
    svg_and_todo_ids = TodoList.get_svg_and_todo_ids(id).as_json(except: [:id])
    TodoStatus.import(svg_and_todo_ids)
    # MySQLだとimportの返り値が空になってしまうので、挿入した分を再度取得して返す
    TodoStatus.where(svg_id: svg_ids).camelize_keys.as_json
  end

  # activeをfalseに更新し、TodoStatusを削除する
  def inactivate
    update(active: false)
    TodoStatus.delete_by(svg_id: svg_ids)
  end
end
