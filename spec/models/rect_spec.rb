require 'rails_helper'

RSpec.describe Rect, type: :model do
  let(:rect) { build(:rect) }

  describe "四角形作成" do
    context '正常系' do
      include_context 'STI default values setup', :rect

      it "有効な属性値の場合、四角形が作成できること" do
        expect{ rect.save }.to change{ Rect.count }.by(1)
      end

      it "fillがない場合、デフォルト値としてwhiteが入っていること" do
        attr.delete(:fill)
        expect{ Rect.create(attr) }.to change{ Rect.count }.by(1)
        expect(Rect.last.fill).to eq 'white'
      end

      it "strokeがない場合、デフォルト値としてblackが入っていること" do
        attr.delete(:stroke)
        expect{ Rect.create(attr) }.to change{ Rect.count }.by(1)
        expect(Rect.last.stroke).to eq 'black'
      end
    end

    context '異常系' do
      after {
        expect{ rect.save }.to_not change{ Rect.count }
      }

      it 'xがない場合、四角形の作成に失敗すること' do
        rect.x = nil
      end

      it 'yがない場合、四角形の作成に失敗すること' do
        rect.y = nil
      end

      it '名前がない場合、四角形の作成に失敗すること' do
        rect.name = nil
      end

      it 'widthがない場合、四角形の作成に失敗すること' do
        rect.width = nil
      end

      it 'heightがない場合、四角形の作成に失敗すること' do
        rect.height = nil
      end

      it 'display_timeがある場合、四角形の作成に失敗すること' do
        rect.display_time = 1.5
      end

      it 'draw_pointsがある場合、四角形の作成に失敗すること' do
        rect.draw_points = '10'
      end
    end
  end
end
