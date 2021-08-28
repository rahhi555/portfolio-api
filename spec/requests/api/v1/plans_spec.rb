require 'rails_helper'

RSpec.describe "Api::V1::Plans", type: :request do
  describe "GET /api/v1/plans" do
    let!(:plan_list) { create_list(:plan, 3) }

    context 'ヘッダーに有効なトークンが存在する場合' do
      it '計画一覧が返ってくること' do
        get api_v1_plans_path, headers: payload_headers
        expect(response).to have_http_status(200)
        expect(parsed_body.size).to eq plan_list.size
      end
    end
  end

  describe "POST /api/v1/plans" do
    context '有効な属性値の場合' do
      let(:user) { create(:user) }
      let(:plan) { build(:plan) }

      it '計画が追加される' do
        expect {
          post api_v1_plans_path, params: { plan: { name: plan.name } }, headers: payload_headers(uid: user.uid)
        }.to change{ User.count }.by(1)

        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq plan.name
        expect(parsed_body['user_id']).to eq user.id
      end
    end
  end

end
