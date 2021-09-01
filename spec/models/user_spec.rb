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
      let!(:user) { create(:user) }
      let!(:plan) { create(:plan, user: user) }

      it 'ユーザーのみ削除され、計画は残ったままになること' do
        expect{
          user.destroy!
        }.to change{ User.count }.by(-1).and change{ Plan.count }.by(0)
      end
    end
  end
end
