require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "Get api/v1/users/:id" do
    let(:user) { create(:user) }

    before { stub_firebase(user) }

    context "有効なidの場合" do
      it "ユーザーを取得できること" do
        get api_v1_user_path(user)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['id']).to eq user.id
      end
    end
  end

  describe "Post api/v1/users" do
    let(:user) { build(:user) }

    context "有効な属性値の場合" do
      it "ユーザーを追加できること" do
        FirebaseIdToken.test!
        payload = JSON.parse File.read("#{Rails.root}/spec/factories/files/payload.json")
        payload = JWT.encode payload, OpenSSL::PKey::RSA.new(FirebaseIdToken::Testing::Certificates.private_key), 'RS256'

        expect{
          post api_v1_users_path, params: { user: { name: 'テストネーム' } }, headers: { Authorization: "Bearer #{payload}" }
        }.to change{ User.count }.by(1)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['name']).to eq 'テストネーム'
      end
    end
  end
end
