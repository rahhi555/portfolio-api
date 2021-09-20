class Todo < ApplicationRecord
  belongs_to :todo_list

  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title, presence: true, length: { maximum: 50 }
end
