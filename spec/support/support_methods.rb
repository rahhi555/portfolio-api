# テストでよく使用する共通処理
module SupportMethods
  # JSON.parseを毎回書くのが面倒なのでメソッド化
  def parsed_body
    JSON.parse(response.body)
  end

  # rect,polyline,pathの初期化処理
  shared_context 'STI default values setup' do |type|
    let(:map) { create(:map) }
    let(:attr) {
      attr = attributes_for(type)
      attr['map_id'] = map.id
      attr
    }
  end

  # ファイルアタッチ
  def attach_file(record)
    setting = { io: File.open("#{Rails.root}/spec/fixtures/files/test_img.png"),
                filename: 'test_img.png',
                content_type: 'image/png' }

    case record
    when User
      record.avatar.attach(setting)
    when Todo
      record.images.attach(setting)
    else
      nil
    end
  end

  # planモデルのメソッドactivateに必要なデータ用意
  shared_context 'Plan Activate default values setup' do
    let(:plan) { create(:plan) }
    let(:map) { create(:map, plan: plan) }
    let!(:todo_lists) { create_list(:todo_list, 3, plan: plan) }
    let!(:todos_first) { create_list(:todo, 5, todo_list: todo_lists[0]) }
    let!(:todos_second) { create_list(:todo, 5, todo_list: todo_lists[1]) }
    let!(:todos_third) { create_list(:todo, 5, todo_list: todo_lists[2]) }
    let!(:svgs_first) { create_list(:svg, 3, map: map, todo_list: todo_lists[0]) }
    let!(:svgs_second) { create_list(:svg, 3, map: map, todo_list: todo_lists[1]) }
    let!(:svgs_third) { create_list(:svg, 3, map: map, todo_list: todo_lists[2]) }
    # 作成されたtodoステータスの合計数
    let!(:todo_statuses_length) {
      (todos_first.length * svgs_first.length) + (todos_second.length * svgs_second.length) + (todos_third.length * svgs_third.length)
    }

    # 別の計画が存在しても正常に動作するかチェックするためのデータ
    let(:another_plan) { create(:plan) }
    let(:another_map) { create(:map, plan: another_plan) }
    let!(:another_todo_lists) { create_list(:todo_list, 3, plan: another_plan) }
    let!(:another_todos_first) { create_list(:todo, 1, todo_list: another_todo_lists[0]) }
    let!(:another_todos_second) { create_list(:todo, 1, todo_list: another_todo_lists[1]) }
    let!(:another_todos_third) { create_list(:todo, 1, todo_list: another_todo_lists[2]) }
    let!(:another_svgs_first) { create_list(:svg, 1, map: another_map, todo_list: another_todo_lists[0]) }
    let!(:another_svgs_second) { create_list(:svg, 1, map: another_map, todo_list: another_todo_lists[1]) }
    let!(:another_svgs_third) { create_list(:svg, 1, map: another_map, todo_list: another_todo_lists[2]) }
  end
end
