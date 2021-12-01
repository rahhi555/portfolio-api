FactoryBot.define do
  factory :todo_status do
    svg
    todo
    status { 'todo' }
  end
end
