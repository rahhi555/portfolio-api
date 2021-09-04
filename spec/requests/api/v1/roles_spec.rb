require 'rails_helper'

RSpec.describe "Api::V1::Roles", type: :request do
  let(:user) { create(:user) }
  let(:valid_headers) { payload_headers(uid: user.uid) }

  describe "GET /api/v1/:plan_id/roles" do
    let(:plan) { create(:plan) }
    let!(:role_list) { create_list(:role, 3, plan: plan) }
    let!(:another_role_list) { create_list(:role, 3) }

    it "ヘッダーに有効なトークンが存在する場合、ロール一覧を取得できること" do
      get api_v1_plan_roles_path(plan.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body[0]['name']).to eq role_list.first.name
      expect(parsed_body.size).to eq role_list.size
    end

    it "ヘッダーにトークンが存在しない場合、ロール一覧を取得できないこと" do
      get api_v1_plan_roles_path(plan.id)
      expect(response).to have_http_status(401)
    end
  end

  describe "POST /api/v1/:plan_id/roles" do
    let(:plan) { create(:plan) }
    let(:role) { build(:role) }

    it "有効な属性値の場合、ロールを作成できること" do
      expect {
        post api_v1_plan_roles_path(plan.id), params: { role: { name: role.name } }, headers: valid_headers
      }.to change{ Role.count }.by(1)
    end

    it "ヘッダーにトークンが存在しない場合、ロールを作成できないこと" do
      expect {
        post api_v1_plan_roles_path(plan.id), params: { role: { name: role.name } }
      }.to_not change{ Role.count }
    end
  end

  describe "PATCH /api/v1/roles/:id" do
    let(:role) { create(:role) }
    let(:update_name) { { name: 'updated_name' } }

    it "有効な属性値の場合ロールを更新できること" do
      patch api_v1_role_path(role.id), params: { role: update_name }, headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq update_name[:name]
    end

    it "ヘッダーにトークンが存在しない場合、ロールを更新できないこと" do
      patch api_v1_role_path(role.id), params: { role: update_name }
      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE /api/v1/roles/:id" do
    let!(:role) { create(:role) }

    it 'ロールを削除できること' do
      expect {
        delete api_v1_role_path(role.id), headers: valid_headers
      }.to change{ Role.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
