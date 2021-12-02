require 'rake_helper'

describe 'plans:inactivate_plans_since_yesterday' do
  subject(:task) { Rake.application['plans:inactivate_plans_since_yesterday'] }
  let(:plan) { create(:plan) }
  let(:map) { create(:map, plan: plan) }
  let!(:todo_list) { create(:todo_list, plan: plan) }
  let!(:todos) { create_list(:todo, 3, todo_list: todo_list) }
  let!(:svgs) { create_list(:svg, 3, map: map, todo_list: todo_list) }

  # 別の計画が存在しても正常に動作するかチェックするためのデータ
  let(:another_plan) { create(:plan) }
  let(:another_map) { create(:map, plan: another_plan) }
  let!(:another_todo_list) { create(:todo_list, plan: another_plan) }
  let!(:another_todos) { create_list(:todo, 2, todo_list: another_todo_list) }
  let!(:another_svgs) { create_list(:svg, 2, map: another_map, todo_list: another_todo_list) }

  # 一日前と現在にactivateした計画をそれぞれ作成
  before do
    travel -1.day do
      plan.activate
    end
    another_plan.activate
  end

  it 'アクティブになってから一日が過ぎた計画は、ノンアクティブになること' do
    expect { task.invoke }.to change { plan.reload.active }.from(true).to(false)
                          .and change { plan.todo_statuses.count }.from(todos.count * svgs.count).to(0)
    # 他の計画に影響がないことを確認する
    expect(another_plan.todo_statuses.count).to eq another_todos.count * another_svgs.count
  end
end