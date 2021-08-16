require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "Get api/v1/users/:id" do
    let(:headers) {
      {
        'Content-Type': 'application/json',
        Authorization: 'Bearer token'
      }
    }
    let(:user) { FactoryBot.create(:user) }

    before { stub_firebase(user) }

    context "有効なidの場合" do
      it "ユーザーを取得できること" do
        get api_v1_user_path(user), headers: headers
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['id']).to eq user.id
      end
    end
  end

  describe "Post api/v1/users" do
    context "有効な属性値の場合" do
      it "ユーザーを追加できること" do
        FirebaseIdToken.test!

        post api_v1_users_path, params: { user: { name: 'テストネーム' } }, headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end
end
