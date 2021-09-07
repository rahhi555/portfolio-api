require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "メンバー作成" do
    let(:role) { create(:role) }
    let(:member) { build(:member, role: role, plan: role.plan) }

    context "正常系" do
      let(:no_role) { build(:member, role: nil) }

      it "有効な属性値の場合、メンバーが作成されること" do
        expect { member.save }.to change{ Member.count }.by(1)
      end

      it "ロールが無くてもメンバーが作成されること" do
        expect { no_role.save }.to change{ Member.count }.by(1)
      end
    end

    context "異常系" do
      let(:no_accept) { build(:member, accept: nil) }
      let(:no_user) { build(:member, user: nil) }
      let(:no_plan) { build(:member, plan: nil) }
      let(:another_plan) { create(:plan) }
      let(:user_plan_not_match) { build(:member, plan: another_plan) }
      let(:dup_member) { build(:member, user: member.user, plan: member.plan) }
      let(:another_plan) { create(:plan) }
      let(:another_plan_member) { build(:member, role: role, plan: another_plan ) }

      it "acceptがない場合は作成されないこと" do
        expect { no_accept.save }.to_not change{ Member.count }
      end

      it "ユーザーがない場合は作成されないこと" do
        expect { no_user.save }.to_not change{ Member.count }
      end

      it "計画がない場合は作成されないこと" do
        expect { no_plan.save }.to_not change{ Member.count }
      end

      it "同じユーザーと計画の組み合わせで作成されないこと" do
        member.save!
        expect { dup_member.save }.to_not change{ Member.count }
      end

      it "計画に存在しないロールの場合は作成されないこと" do
        expect { another_plan_member.save }.to_not change{ Member.count }
      end
    end
  end

  describe "メンバー更新" do
    let(:member) { create(:member) }
    let(:no_role_member) { create(:member, role: nil) }
    let(:role) { create(:role, plan_id: no_role_member.plan.id) }

    context "正常系" do
      it "acceptをtrueに更新できること" do
        member.update(accept: true)
        expect(member.accept).to eq true
      end

      it "roleを追加できること" do
        no_role_member.update(role: role)
        expect(no_role_member.role).to eq role
      end
    end

    context "異常系" do
      let(:another_role) { create(role) }
      it "計画に存在しないロールの場合は追加できないこと" do
        expect {
          member.update(role: role)
          member.reload
        }.to_not change{ member.role }
      end
    end
  end
end
