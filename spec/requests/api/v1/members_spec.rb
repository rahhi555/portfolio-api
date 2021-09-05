require 'rails_helper'

RSpec.describe "Api::V1::Members", type: :request do
  let(:user) { create(:user) }
  let(:valid_header) { payload_headers(uid: user.uid) }
  let(:invalid_header) { payload_headers }
  let!(:plan) { create(:plan) }

  describe "GET /api/v1/:plan_id/members" do
    let(:member_list) { create_list(:member, 3, plan: plan) }
    let(:another_plan) { create(:plan) }
    let(:another_member_list) { create_list(:member, 3, plan: another_plan) }

    context '正常系' do
      it 'ヘッダーに有効なトークンが存在する場合、メンバー一覧が返ること' do
        get api_v1_plan_members_path(member_list.first.plan), headers: valid_header
        expect(response).to have_http_status(200)
        expect(parsed_body.size).to eq member_list.size
      end
    end

    context '異常系' do
      it 'ヘッダーにトークンが存在しない場合、401が返ること' do
        get api_v1_plan_members_path(member_list.first.plan)
        expect(response).to have_http_status(401)
      end

      it 'ヘッダーに無効なトークンが存在する場合、401が返ること' do
        get api_v1_plan_members_path(member_list.first.plan)
        expect(response).to have_http_status(401), headers: invalid_header
      end
    end
  end

  describe "POST /api/v1/plans/:plan_id/members" do
    let(:member_params) { attributes_for(:member).merge(user_id: user.id) }

    context '正常系' do
      it '有効な属性値の場合メンバーが作成されること' do
        expect {
          post api_v1_plan_members_path(plan.id), params: { member: member_params }, headers: valid_header
        }.to change{ Member.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end

    context '異常系' do
      it 'ヘッダーにトークンが存在しない場合、401が返ること' do
        post api_v1_plan_members_path(plan.id), params: { member: member_params }
        expect(response).to have_http_status(401)
      end

      it 'ヘッダーに無効なトークンが存在する場合、401が返ること' do
        post api_v1_plan_members_path(plan.id), params: { member: member_params }, headers: invalid_header
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /api/v1/members/:id' do
    let!(:member) { create(:member, user_id: user.id) }

    context '正常系' do
      it 'メンバーを削除できること' do
        expect {
          delete api_v1_member_path(member.id), headers: valid_header
        }.to change{ Member.count }.by(-1)
        expect(response).to have_http_status(200)
      end
    end
  end
end
