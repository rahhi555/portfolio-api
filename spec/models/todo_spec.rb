require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'バリデーションテスト' do
    subject(:todo) { create(:todo) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to have_many_attached(:images) }
  end

  describe 'アソシエーションテスト' do
    subject(:todo) { create(:todo) }

    it { is_expected.to belong_to(:todo_list) }
  end

  describe '画像添付' do
    let(:todo) { create(:todo) }

    it '画像をアタッチできること' do
      expect { attach_file(todo) }.to change{ todo.images.attached? }.from(false).to(true)
    end

    it '10MiBより大きい画像は添付できないこと' do
      todo.images.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_img_10MB.png"),
                         filename: 'test_img_10MB.png',
                         content_type: 'image/png')
      expect(todo.errors.full_messages[0]).to match '10 MB以下にしてください'
      expect(todo.reload.images.attached?).to eq false
    end

    it '画像以外は添付できないこと' do
      todo.images.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_zip.zip"),
                         filename: 'test_zip.zip',
                         content_type: 'application/zip')
      expect(todo.errors.full_messages[0]).to match 'zipは対応できないファイル形式です'
      expect(todo.reload.images.attached?).to eq false
    end
  end
end
