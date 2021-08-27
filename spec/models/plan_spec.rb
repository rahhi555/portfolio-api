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
  end
end
