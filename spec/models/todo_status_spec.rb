require 'rails_helper'

RSpec.describe TodoStatus, type: :model do
  describe 'バリデーションテスト' do
    it { is_expected.to define_enum_for(:status).with_values(todo: 0, doing: 1, done: 2) }
  end

  describe 'Todoステータス作成' do
    context '正常系' do
      let(:todo_list) { create(:todo_list) }
      let(:svg) { create(:svg, todo_list: todo_list) }
      let(:todo) { create(:todo, todo_list: todo_list) }

      it 'svgとtodoが持つtodo_list_idが同じ場合,ステータスがtodoで作成される' do
        expect{
          TodoStatus.create(svg: svg, todo: todo)
        }.to change{ TodoStatus.count }.by(1)
        expect(TodoStatus.last.status).to eq 'todo'
      end
    end
  end
end
