require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'Todoリスト作成' do
    let(:todo_list) { build(:todo_list) }

    context '正常系' do
      it '有効な属性値の場合、Todoリストが作成されること' do
        expect { todo_list.save }.to change{ TodoList.count }.by(1)
      end
    end

    context '異常系' do
      it 'titleがnilの場合、作成できないこと' do
        todo_list.title = nil
        expect { todo_list.save }.to_not change{ TodoList.count }
        expect(todo_list.errors.full_messages[0]).to eq "Title can't be blank"
      end

      it 'titleが256文字異常の場合、作成できないこと' do
        todo_list.title = 'a' * 255
        expect { todo_list.save }.to change{ TodoList.count }.by(1)
        todo_list.title = 'a' * 256
        expect { todo_list.save }.to_not change{ TodoList.count }
        expect(todo_list.errors.full_messages[0]).to eq "Title is too long (maximum is 255 characters)"
      end
    end
  end

  describe 'Todoリスト削除' do
    let(:svg) { create(:svg) }
    it 'svgに紐付いたTodoリストを削除した場合、svgは削除されないこと' do
      expect(svg.todo_list.nil?).to eq false
      expect {
        svg.todo_list.destroy!
      }.to change{ TodoList.count }.by(-1).and change{ Svg.count }.by(0)
      expect(svg.reload.todo_list.nil?).to eq true
    end
  end
end
