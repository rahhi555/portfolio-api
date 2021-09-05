require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'ロール作成' do
    let(:role) { build(:role) }
    context '正常系' do
      it '有効な値なら、ロールが作成されること' do
        expect{ role.save }.to change{ Role.count }.by(1)
        expect(role.plan).to_not be_nil
      end

      let(:another_role) { build(:role, name: role.name) }
      it '同一の名前でも計画が異なれば、ロールが作成されること' do
        role.save!
        expect{ another_role.save }.to change{ Role.count }.by(1)
      end
    end

    context '異常系' do
      it '名前が50文字より多い場合、作成に失敗すること' do
        role.name = 'a' * 51
        expect{ role.save }.to_not change{ Role.count }
        expect(role.errors.full_messages).to be_include('Name is too long (maximum is 50 characters)')
      end

      let(:another_role) { build(:role, name: role.name, plan: role.plan) }
      it '同一計画で名前が重複した場合、作成に失敗すること' do
        role.save!
        expect{ another_role.save }.to_not change{ Role.count }
        expect(another_role.errors.full_messages).to be_include('Name has already been taken')
      end
    end
  end

  describe 'ロール削除' do
    let!(:member) { create(:member) }
    it 'メンバーに紐付いたロールを削除した場合、メンバーは残ったままになること' do
      expect {
        member.role.destroy
      }.to change { Role.count }.by(-1).and change { Member.count }.by(0)
    end
  end
end
