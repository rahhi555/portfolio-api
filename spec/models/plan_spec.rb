require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '計画作成' do
    context '正常な値のとき' do
      let(:plan) { build(:plan) }

      it '計画が作成される' do
        expect{ plan.save }.to change{ Plan.count }.to(1)
      end
    end

    context '外部キーを設定していない場合' do
      let(:plan) { build(:plan, user: nil) }

      it '計画が作成されない' do
        expect{ plan.save }.to_not change{ Plan.count }
      end
    end

    context "名前が50文字より多い場合" do
      let(:over_name) { build(:plan, name: 'a'*51) }

      it "計画が作成されない" do
        expect{ over_name.save }.to_not change{ Plan.count }
      end
    end

    context "名前が空白の場合" do
      let(:empty_name) { build(:plan, name: '') }

      it "計画が作成されない" do
        expect{ empty_name.save }.to_not change{ Plan.count }
      end
    end
  end

  describe '計画削除' do
    context 'ロールに紐付いた計画を削除した場合' do
      let!(:role) { create(:role) }

      it 'ロールも一緒に削除されること' do
        expect{
          role.plan.destroy!
        }.to change{ Plan.count }.by(-1).and change { Role.count }.by(-1)
      end
    end

    context 'メンバーに紐付いた計画を削除した場合' do
      let!(:member) { create(:member) }

      it 'メンバーも一緒に削除されること' do
        expect{
          member.plan.destroy!
        }.to change{ Plan.count }.by(-1).and change { Member.count }.by(-1)
      end
    end

    context 'マップに紐付いた計画を削除した場合' do
      let!(:map) { create(:map) }

      it 'マップも一緒に削除されること' do
        expect{
          map.plan.destroy!
        }.to change{ Plan.count }.by(-1).and change { Map.count }.by(-1)
      end
    end

    context 'Todoリストに紐付いた計画を削除した場合' do
      let!(:todo_list) { create(:todo_list) }

      it 'Todoリストも一緒に削除されること' do
        expect{
          todo_list.plan.destroy!
        }.to change{ Plan.count }.by(-1).and change { TodoList.count }.by(-1)
      end
    end
  end

  describe '計画開始・終了' do
    include_context 'Plan Activate default values setup'

    it '計画開始メソッドを実行した場合、activeはtrueに更新されTodoStatusがsvg * todo分作成されること' do
      expect{
        plan.activate
      }.to change{ plan.active }.from(false).to(true)
       .and change{ TodoStatus.count }.to(todo_statuses_length)
    end

    it '計画終了メソッドを実行した場合、activeはfalseに更新され計画に関連するTodoStatusが全削除されること' do
      todo_statues = plan.activate
      another_todo_statues = another_plan.activate
      expect{
        plan.inactivate
      }.to change{ plan.active }.from(true).to(false)
       .and change{ TodoStatus.count }.by(-todo_statues.count)
      expect( TodoStatus.where(svg_id: plan.svg_ids).count ).to eq 0
      expect( TodoStatus.where(svg_id: another_plan.svg_ids).count ).to eq another_todo_statues.count
    end
  end
end
