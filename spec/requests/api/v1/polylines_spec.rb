require 'rails_helper'

RSpec.describe "Api::V1::Svgs Polyline", type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:map) { create(:map) }

  describe "POST /api/v1/maps/:map_id" do
    let(:polyline) { attributes_for(:polyline) }

    it "display_orderが自動入力されてマーカーが作成される" do
      expect {
        post api_v1_map_svgs_path(map.id), params: { svg: polyline } ,headers: valid_headers
      }.to change{ Polyline.count }.by(1)
      expect(response).to have_http_status(200)
      expect(parsed_body['displayOrder']).to eq map.svgs.maximum(:display_order).to_i
    end
  end
end