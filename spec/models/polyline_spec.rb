require 'rails_helper'

RSpec.describe Polyline, type: :model do
  describe 'マーカー作成' do
    let(:polyline) { build(:polyline) }
    context '正常系' do
      include_context 'STI default values setup', :polyline

      it '有効な属性値の場合、マーカーが作成される' do
        expect{ polyline.save! }.to change{ Polyline.count }.by(1)
      end
    end

    context '異常系' do
      after {
        expect{ polyline.save }.to_not change{ Rect.count }
      }

      it 'widthが存在する場合、マーカーが作成されないこと' do
        polyline.width = 10
      end

      it 'heightが存在する場合、マーカーが作成されないこと' do
        polyline.height = 10
      end

      it 'display_timeが存在しない場合、マーカーが作成されないこと' do
        polyline.display_time = nil
      end

      it 'draw_pointsが存在しない場合、マーカーが作成されないこと' do
        polyline.draw_points = nil
      end
    end
  end
end
