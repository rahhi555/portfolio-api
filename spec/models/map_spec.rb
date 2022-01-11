require 'rails_helper'

RSpec.describe Map, type: :model do
  describe "マップ作成" do
    let(:map) { build(:map) }

    context '正常系' do
      let(:dup_name_map) { build(:map, name: map.name) }

      it '有効な属性値の場合、マップを作成できること' do
        expect { map.save }.to change{ Map.count }.by(1)
      end

      it '異なる計画で名前が重複した場合、マップを作成できること' do
        map.save
        expect{ dup_name_map.save }.to change{ Map.count }.by(1)
      end
    end

    context '異常系' do
      let(:map) { build(:map) }
      let(:dup_name_and_plan_map) { build(:map, name: map.name, plan: map.plan) }

      it '同一計画で名前が重複した場合、マップの作成に失敗すること' do
        map.save
        expect{ dup_name_and_plan_map.save }.to_not change{ Map.count }
        expect(dup_name_and_plan_map.errors.full_messages[0]).to eq 'Name has already been taken'
      end
    end

    context '境界値テスト' do
      it { is_expected.to validate_length_of(:name) }

      let(:valid_under_boundary) { build(:map, :valid_under_boundary) }
      let(:invalid_under_boundary) { build(:map, :invalid_under_boundary) }
      let(:valid_upper_boundary) { build(:map, :valid_upper_boundary) }
      let(:invalid_upper_boundary) { build(:map, :invalid_upper_boundary) }
      it 'boundsのnorthとsouthは-90~90,westとeastは-180~180であること' do
        expect(valid_under_boundary.valid?).to be true
        expect(invalid_under_boundary.valid? ).to be false
        expect(valid_upper_boundary.valid? ).to be true
        expect(invalid_upper_boundary.valid? ).to be false
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

  describe 'マップ更新' do
    let!(:map) { create(:map) }
    context '正常系' do
      let(:use_google_map) { attributes_for(:map, :use_google_map) }
      it '正常な値なら更新できること' do
        map.update!(use_google_map)
        map.reload
        expect(map.attributes.deep_symbolize_keys).to include use_google_map
      end
    end

    context '異常系' do
      let(:over_bounds_key) { attributes_for(:map, :over_bounds_key) }
      let(:less_bounds_key) { attributes_for(:map, :less_bounds_key) }

      it 'boundsに余計なキーがあると更新できない' do
        map.update(over_bounds_key)
        expect(map.valid?).to eq false
      end

      it 'boundsに規定のキーがないと更新できない' do
        map.update(less_bounds_key)
        expect(map.valid?).to eq false
      end
    end
  end
end
