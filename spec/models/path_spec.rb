require 'rails_helper'

RSpec.describe Path, type: :model do
  describe 'ピン作成' do
    let(:path) { build(:path) }
    context '正常系' do
      include_context 'STI default values setup', :path

      it '有効な属性値の場合、ピンが作成される' do
        expect{ path.save }.to change{ Path.count }.by(1)
      end
    end

    context '異常系' do
      after {
        expect{ path.save }.to_not change{ Rect.count }
      }

      it 'widthが存在する場合、ピンが作成されないこと' do
        path.width = 10
      end

      it 'heightが存在する場合、ピンが作成されないこと' do
        path.height = 10
      end

      it 'display_timeが存在しない場合、ピンが作成されないこと' do
        path.display_time = nil
      end

      it 'draw_pointsが存在しない場合、ピンが作成されないこと' do
        path.draw_points = nil
      end
    end
  end
end
