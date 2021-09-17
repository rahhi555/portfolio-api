require 'rails_helper'

RSpec.describe 'Api::V1::Svgs Path', type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:map) { create(:map) }

  describe "POST /api/v1/maps/:map_id/svgs" do
    let(:path) { attributes_for(:path) }

    it "display_orderが自動入力されてピンが作成されること" do
      expect {
        post api_v1_map_svgs_path(map.id), params: { svg: path } ,headers: valid_headers
      }.to change{ Path.count }.by(1)
      expect(response).to have_http_status(200)
      expect(parsed_body['displayOrder']).to eq map.next_display_order - 1
    end
  end
end