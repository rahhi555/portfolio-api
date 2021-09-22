require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー作成" do
    context "正常な値のとき" do
      let(:user) { build(:user) }

      it "ユーザーが作成される" do
        expect{ user.save }.to change{ User.count }.to(1)
      end
    end

    context "名前が50文字より多い場合" do
      let(:over_name) { build(:user, name: 'a'*51) }

      it "ユーザーが作成されない" do
        expect{ over_name.save }.to_not change{ User.count }
      end
    end

    context "名前が空白の場合" do
      let(:blank_name) { build(:user, name: '') }

      it "ユーザーが作成されない" do
        expect{ blank_name.save }.to_not change{ User.count }
      end
    end

    context "uidが空白の場合" do
      let(:blank_uid) { build(:user, uid: '') }

      it "ユーザーが作成されない" do
        expect{ blank_uid.save }.to_not change{ User.count }
      end
    end

    context "uidが重複している場合" do
      let!(:user) { create(:user) }
      let(:dup_user) { build(:user, uid: user.uid) }

      it "ユーザーが作成されない" do
        expect{ dup_user.save }.to_not change{ User.count }
      end
    end
  end

  describe 'ユーザー削除' do
    context '計画に紐付いたユーザーを削除した場合' do
      let!(:plan) { create(:plan) }

      it '計画は残ったままになること' do
        expect{
          plan.user.destroy!
        }.to change{ User.count }.by(-1).and change{ Plan.count }.by(0)
      end
    end

    context 'メンバーに紐付いたユーザーを削除した場合' do
      let!(:member) { create(:member) }

      it 'メンバーも削除されること' do
        expect{
          member.user.destroy!
        }.to change{ User.count }.by(-1).and change{ Member.count }.by(-1)
      end
    end
  end

  describe 'ユーザー更新' do
    let(:user) { create(:user) }

    it 'アバター画像をアタッチできること' do
      expect {
        attach_file(user)
      }.to change{ user.avatar.attached? }.from(false).to(true)
    end

    it '10MiBより大きい画像は添付できないこと' do
      user.avatar.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_img_10MB.png"),
                         filename: 'test_img_10MB.png',
                         content_type: 'image/png')
      expect(user.errors.full_messages[0]).to match '10 MB以下にしてください'
      expect(user.reload.avatar.attached?).to eq false
    end

    it '画像以外は添付できないこと' do
      user.avatar.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_zip.zip"),
                         filename: 'test_zip.zip',
                         content_type: 'application/zip')
      expect(user.errors.full_messages[0]).to match 'zipは対応できないファイル形式です'
      expect(user.reload.avatar.attached?).to eq false
    end
  end
end
