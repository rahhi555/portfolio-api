require 'rails_helper'

RSpec.describe "Api::V1::TodoStatuses", type: :request do
  context "GET /api/v1/plans/:plan_id/todo_statuses" do
    include_context 'Plan Activate default values setup'

    it "todoステータス一覧が返ってくること" do
      plan.activate
      get api_v1_plan_todo_statuses_path(plan), headers: payload_headers(uid: plan.user.uid)
      expect(response).to have_http_status(:success)
      expect(parsed_body.length).to eq todo_statuses_length
    end
  end
end
