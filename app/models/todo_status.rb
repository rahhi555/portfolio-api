class TodoStatus < ApplicationRecord
  belongs_to :svg
  belongs_to :todo

  enum status: { todo: 0, doing: 1, done: 2 }
end
