require 'rails_helper'

RSpec.describe "Api::V1::Svgs Rect", type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:map) { create(:map) }

  describe "GET /api/v1/maps/:map_id/rects" do
    let!(:rect_list) { create_list(:rect, 3, map: map) }
    let!(:another_rect_list) { create_list(:rect, 3) }

    it "ヘッダーに有効なトークンが存在する場合、四角形一覧を取得できること" do
      get api_v1_map_rects_path(map.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body[0]['name']).to eq rect_list.first.name
      expect(parsed_body.size).to eq rect_list.size
    end
  end

  describe "POST /api/v1/maps/:map_id/rects" do
    let(:rect) { attributes_for(:rect) }

    it "有効な属性値の場合、四角形一覧を作成できること" do
      expect {
        post api_v1_map_rects_path(map.id), params: { rect: rect } ,headers: valid_headers
      }.to change{ Rect.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/rects/:id" do
    let(:rect) { create(:rect) }

    it "有効な属性値の場合、四角形一覧を更新できること" do
      patch api_v1_rect_path(rect.id), params: { rect: { name: 'new Rect' } } ,headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq 'new Rect'
    end
  end

  describe "DELETE /api/v1/rects/:id" do
    let!(:rect) { create(:rect) }

    it "ヘッダーにトークンがある場合、四角形一覧を削除できること" do
      expect {
        delete api_v1_rect_path(rect.id), headers: valid_headers
      }.to change{ Rect.count }.by(-1)
      expect(response).to have_http_status(200)
      expect(parsed_body['id']).to eq rect.id
    end
  end
end