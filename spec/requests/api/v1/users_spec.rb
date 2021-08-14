require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "Post api/v1/users" do
    context "有効な属性値の場合" do
      it "ユーザーを追加できること" do
        post api_v1_users_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
