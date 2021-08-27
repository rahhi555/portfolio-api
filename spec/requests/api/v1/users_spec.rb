require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "Get api/v1/users/:id" do
    let(:user) { create(:user) }

    before { stub_firebase(user) }

    context "有効なidの場合" do
      it "ユーザーを取得できること" do
        get api_v1_user_path(user)
        expect(response).to have_http_status(200)
        expect(parsed_body['id']).to eq user.id
      end
    end
  end

  describe "Post api/v1/users" do
    let(:user) { build(:user) }

    context "有効な属性値の場合" do
      it "ユーザーを追加できること" do
        expect{
          post api_v1_users_path, params: { user: { name: 'テストネーム' } }, headers: payload_headers
        }.to change{ User.count }.by(1)
        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq 'テストネーム'
      end
    end

    context "ヘッダーにトークンが無い場合" do
      it "401エラーが返ること" do
        expect{
          post api_v1_users_path, params: { user: { name: 'テストネーム' } }, headers: { Authorization: "Bearer " }
        }.to_not change{ User.count }

        expect(response).to have_http_status(401)
        expect(parsed_body['message']).to eq 'Unauthorized'
      end
    end

    context "nameがない場合" do
      it "400エラーが返ること" do
        expect{
          post api_v1_users_path, params: { user: { name: '' } }, headers: payload_headers
        }.to_not change{ User.count }

        expect(response).to have_http_status(400)
        expect(parsed_body['message']).to eq 'Bad Request'
        expect(parsed_body['errors'][0]).to eq "Validation failed: Name can't be blank"
      end
    end
  end

  describe "Get api/v1/me" do
    let!(:user) { create(:user) }

    context "ヘッダーに有効なトークンが存在する場合" do
      it "トークンのユーザーを返すこと" do
        get api_v1_me_path, headers: payload_headers(uid: user.uid)
        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq user.name
      end
    end

    context "ヘッダーにトークンが無い場合" do
      it "401エラーが返ること" do
        get api_v1_me_path
        expect(response).to have_http_status(401)
        expect(parsed_body['message']).to eq 'Unauthorized'
      end
    end
  end

  describe "Delete api/v1/me" do
    context "ヘッダーに有効なトークンが存在する場合" do
      let!(:user) { create(:user) }

      it "ユーザーが削除されること" do
        expect {
          delete api_v1_me_path, headers: payload_headers(uid: user.uid)
        }.to change{ User.count }.by(-1)

        expect(response).to have_http_status(200)
        expect(parsed_body['uid']).to eq user.uid
      end
    end

    context "ヘッダーにトークンが無い場合" do
      it "401エラーが返ること" do
        delete api_v1_me_path
        expect(response).to have_http_status(401)
        expect(parsed_body['message']).to eq 'Unauthorized'
      end
    end
  end
end
