require 'rails_helper'

RSpec.describe 'Api::V1::Svgs Path', type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:map) { create(:map) }

  describe "GET /api/v1/maps/:map_id/paths" do
    let!(:path_list) { create_list(:path, 3, map: map) }
    let!(:another_path_list) { create_list(:path, 3) }

    it "ヘッダーに有効なトークンが存在する場合、ピン一覧を取得できること" do
      get api_v1_map_paths_path(map.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body[0]['name']).to eq path_list.first.name
      expect(parsed_body.size).to eq path_list.size
    end
  end

  describe "POST /api/v1/maps/:map_id/paths" do
    let(:path) { attributes_for(:path) }

    it "有効な属性値の場合、ピン一覧を作成できること" do
      expect {
        post api_v1_map_paths_path(map.id), params: { path: path } ,headers: valid_headers
      }.to change{ Path.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/paths/:id" do
    let(:path) { create(:path) }

    it "有効な属性値の場合、ピン一覧を更新できること" do
      patch api_v1_path_path(path.id), params: { path: { name: 'new Path' } } ,headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq 'new Path'
    end
  end

  describe "DELETE /api/v1/paths/:id" do
    let!(:path) { create(:path) }

    it "ヘッダーにトークンがある場合、ピン一覧を削除できること" do
      expect {
        delete api_v1_path_path(path.id), headers: valid_headers
      }.to change{ Path.count }.by(-1)
      expect(response).to have_http_status(200)
      expect(parsed_body['id']).to eq path.id
    end
  end

end