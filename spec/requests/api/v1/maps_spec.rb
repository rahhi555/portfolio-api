require 'rails_helper'

RSpec.describe "Api::V1::Maps", type: :request do
  let(:plan) { create(:plan) }
  let(:valid_headers) { payload_headers(uid: plan.user.uid) }

  describe "GET /api/v1/:plan_id/maps" do
    let!(:map_list) { create_list(:map, 3, plan_id: plan.id) }
    let!(:another_map_list) { create_list(:map, 3) }

    it "マップを取得できること" do
      get api_v1_plan_maps_path(plan.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body.size).to eq 3
    end
  end

  describe "POST /api/v1/:plan_id/maps" do
    let(:map) { attributes_for(:map) }

    it "マップを作成できること" do
      expect {
        post api_v1_plan_maps_path(plan.id), params: { map: map }, headers: valid_headers
      }.to change{ Map.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /api/v1/maps/:id" do
    let!(:map) { create(:map, plan_id: plan.id) }
    let(:another_user) { create(:user) }

    it "作成者本人の場合削除できること" do
      expect {
        delete api_v1_map_path(map.id), headers: valid_headers
      }.to change{ Map.count }.by(-1)
      expect(response).to have_http_status(200)
    end

    it "作成者以外のマップは削除できないこと" do
      expect {
        delete api_v1_map_path(map.id), headers: payload_headers(uid: another_user.uid)
      }.to_not change{ Map.count }
      expect(parsed_body['message']).to eq "Record Not Found"
    end
  end

  describe "PATCH /api/v1/maps/:id" do
    let!(:map) { create(:map) }
    let(:map_params) { { name: 'new map name' } }

    it 'マップを更新できること' do
      patch api_v1_map_path(map.id), params: { map: map_params }, headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq map_params[:name]
    end
  end
end
