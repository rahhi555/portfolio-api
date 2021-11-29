FactoryBot.define do
  factory :todo do
    todo_list
    title { "Todo Title" }
    body { "Todo body" }
    begin_time { "2021-09-19 03:27:19" }
    end_time { "2021-09-19 03:27:19" }
  end
end
