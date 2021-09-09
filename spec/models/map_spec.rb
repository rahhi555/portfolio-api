require 'rails_helper'

RSpec.describe Map, type: :model do
  let(:map) { build(:map) }

  describe "マップ作成" do
    context '正常系' do
      let(:dup_name_map) { build(:map, name: map.name) }

      it '有効な属性値の場合、マップを作成できること' do
        expect { map.save }.to change{ Map.count }.by(1)
      end

      it '異なる計画で名前が重複した場合、マップを作成できること' do
        map.save
        expect{ dup_name_map.save }.to change{ Map.count }.by(1)
      end

      it '名前が50文字ならマップを作成できること' do
        map.name = 'a' * 50
        expect{ map.save }.to change{ Map.count }.by(1)
      end
    end

    context '異常系' do
      let(:dup_name_and_plan_map) { build(:map, name: map.name, plan: map.plan) }

      it '同一計画で名前が重複した場合、マップの作成に失敗すること' do
        map.save
        expect{ dup_name_and_plan_map.save }.to_not change{ Map.count }
        expect(dup_name_and_plan_map.errors.full_messages[0]).to eq 'Name has already been taken'
      end

      it '名前が51文字ならマップの作成に失敗すること' do
        map.name = 'a' * 51
        expect{ map.save }.to_not change{ Map.count }
        expect(map.errors.full_messages[0]).to eq 'Name is too long (maximum is 50 characters)'
      end
    end
  end

  describe 'マップ削除' do
    context 'SVGに紐付いた計画を削除した場合' do
      let!(:map){ create(:map) }
      let!(:rect) { create(:rect, map_id: map.id) }
      let!(:path) { create(:path, map_id: map.id) }
      let!(:polyline) { create(:polyline, map_id: map.id) }

      it 'SVGも一緒に削除されること' do
        expect{
          map.destroy!
        }.to change{ Map.count }.by(-1).and change { Svg.count }.by(-3)
      end
    end
  end
end
