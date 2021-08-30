require 'rails_helper'

RSpec.describe "Api::V1::Plans", type: :request do
  describe "GET /api/v1/plans" do
    let!(:plan_list) { create_list(:plan, 3) }

    context 'ヘッダーに有効なトークンが存在する場合' do
      it '計画一覧が返ってくること' do
        get api_v1_plans_path, headers: payload_headers(uid: plan_list[0].user.uid)

        expect(response).to have_http_status(200)
        expect(parsed_body.size).to eq plan_list.size
      end
    end

    context 'ヘッダーにトークンが存在しない場合' do
      it '401エラーが返ってくること' do
        get api_v1_plans_path

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST /api/v1/plans" do
    let(:user) { create(:user) }
    let(:plan) { build(:plan) }

    context '有効な属性値の場合' do
      it '計画が追加されること' do
        expect {
          post api_v1_plans_path, params: { plan: { name: plan.name } }, headers: payload_headers(uid: user.uid)
        }.to change{ User.count }.by(1)

        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq plan.name
        expect(parsed_body['author']).to eq user.name
      end
    end

    context 'nameが空白の場合' do
      it 'バリデーションエラーが返ること' do
        expect{
          post api_v1_plans_path, params: { plan: { name: '' } }, headers: payload_headers(uid: user.uid)
        }.to_not change{ Plan.count }

        expect(response).to have_http_status(400)
        expect(parsed_body['errors'][0]).to eq "Validation failed: Name can't be blank"
      end
    end

    context 'ヘッダーにトークンが存在しない場合' do
      it '401エラーが返ること' do
        expect{
          post api_v1_plans_path, params: { plan: { name: plan.name } }, headers: payload_headers
        }.to_not change{ Plan.count }

        expect(response).to have_http_status(401)
      end
    end
  end


  describe "DELETE /api/v1/plans/:id" do
    let(:another_user) { create(:user) }
    let!(:plan) { create(:plan) }

    context 'ヘッダーにトークンが存在する場合' do
      it '計画を削除できること' do
        expect{
          delete api_v1_plan_path(plan), headers:payload_headers(uid: plan.user.uid)
        }.to change{ Plan.count }.by(-1)

        expect(response).to have_http_status(200)
      end
    end

    context 'ヘッダーに他人のトークンが存在する場合' do
      it '計画を削除できないこと' do
        expect{
          delete api_v1_plan_path(plan), headers:payload_headers(uid: another_user.uid)
        }.to_not change{ Plan.count }

        expect(response).to have_http_status(404)
      end
    end
  end
  
end
