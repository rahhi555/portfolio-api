require 'rails_helper'

RSpec.describe "Api::V1::Svgs", type: :request do
  let(:valid_headers) { payload_headers(uid: user.uid) }
  let(:user) { create(:user) }
  let(:plan) { create(:plan) }
  let(:map_one) { create(:map, plan_id: plan.id) }
  let(:map_two) { create(:map, plan_id: plan.id) }
  let(:map_three) { create(:map, plan_id: plan.id) }

  describe "GET /api/v1/plans/:plan_id/svgs" do
    let!(:svg_list_one) { create_list(:rect, 2, map: map_one) }
    let!(:svg_list_two) { create_list(:path, 2, map: map_two) }
    let!(:svg_list_three) { create_list(:polyline, 2, map: map_three) }
    let!(:another_plan_list) { create_list(:rect, 2) }

    it "ヘッダーに有効なトークンが存在する場合、すべての図形を取得できること" do
      get api_v1_plan_svgs_path(plan.id), headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body.size).to eq svg_list_one.size + svg_list_two.size + svg_list_three.size
    end
  end

  describe "PATCH /api/v1/rects/:id" do
    let(:rect) { create(:rect) }

    it "有効な属性値の場合、図形を更新できること" do
      patch api_v1_svg_path(rect.id), params: { svg: { name: 'new Rect' } } ,headers: valid_headers
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq 'new Rect'
    end
  end

  describe "DELETE /api/v1/svgs/:id" do
    let!(:rect) { create(:rect) }

    it "ヘッダーにトークンがある場合、図形を削除できること" do
      expect {
        delete api_v1_svg_path(rect.id), headers: valid_headers
      }.to change{ Rect.count }.by(-1)
      expect(response).to have_http_status(200)
      expect(parsed_body['id']).to eq rect.id
    end
  end

end