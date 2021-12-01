class TodoList < ApplicationRecord
  belongs_to :plan
  has_many :svgs, dependent: :nullify
  has_many :todos, -> { includes(images_attachments: :blob) }, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }

  # activateに必要最小限のsvgsとtodosのカラムを取得する
  # svgs.todo_list_id = todos.todo_list_idの場合のEXPLAINと比較した場合、こちらのほうがパフォーマンスが良さそうだったのでこっちを採用
  scope :get_svg_and_todo_ids, lambda { |_plan_id|
    select('svgs.id AS svg_id, todos.id AS todo_id')
      .joins(:todos, :svgs)
      .where(plan_id: _plan_id)
  }
end
