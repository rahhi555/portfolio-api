require 'rails_helper'

RSpec.describe "Api::V1::Svgs Polyline", type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:map) { create(:map) }

  describe "GET /api/v1/maps/:map_id/polylines" do
    let!(:polyline_list) { create_list(:polyline, 3, map: map) }
    let!(:another_polyline_list) { create_list(:polyline, 3) }

    it "ヘッダーに有効なトークンが存在する場合、マーカー一覧を取得できること" do
      get api_v1_map_polylines_path(map.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body[0]['name']).to eq polyline_list.first.name
      expect(parsed_body.size).to eq polyline_list.size
    end
  end

  describe "POST /api/v1/maps/:map_id/polylines" do
    let(:polyline) { attributes_for(:polyline) }

    it "有効な属性値の場合、マーカー一覧を作成できること" do
      expect {
        post api_v1_map_polylines_path(map.id), params: { polyline: polyline } ,headers: valid_headers
      }.to change{ Polyline.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/polylines/:id" do
    let(:polyline) { create(:polyline) }

    it "有効な属性値の場合、マーカー一覧を更新できること" do
      patch api_v1_polyline_path(polyline.id), params: { polyline: { name: 'new Polyline' } } ,headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq 'new Polyline'
    end
  end

  describe "DELETE /api/v1/polylines/:id" do
    let!(:polyline) { create(:polyline) }

    it "ヘッダーにトークンがある場合、マーカー一覧を削除できること" do
      expect {
        delete api_v1_polyline_path(polyline.id), headers: valid_headers
      }.to change{ Polyline.count }.by(-1)
      expect(response).to have_http_status(200)
      expect(parsed_body['id']).to eq polyline.id
    end
  end
end