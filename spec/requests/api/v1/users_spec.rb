require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET api/v1/users/:id" do
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

  describe "POST api/v1/users" do
    let(:user) { build(:user) }

    context "有効な属性値の場合" do
      it "ユーザーを追加できること" do
        expect{
          post api_v1_users_path,
               params: { user: { name: user.name } },
               headers: payload_headers
        }.to change{ User.count }.by(1)
        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq user.name
      end
    end

    context "ヘッダーにトークンが無い場合" do
      it "401エラーが返ること" do
        expect{
          post api_v1_users_path, params: { user: user.attributes }
        }.to_not change{ User.count }

        expect(response).to have_http_status(401)
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

    describe 'PATCH /api/v1/me' do
      context "有効な属性値の場合" do
        let!(:user) { create(:user) }
        let(:update_user) { attributes_for(:user, name: 'update_user') }

        it "ユーザーを更新できること" do
          patch api_v1_me_path,
                params: { user: update_user },
                headers: payload_headers(uid: user.uid)
          expect(response).to have_http_status(200)
          expect(parsed_body['provider']).to eq 'google'
          expect(parsed_body['name']).to eq update_user[:name]
        end

        it 'アバター画像をアタッチできること' do
          update_user[:avatar] = Rack::Test::UploadedFile.new("spec/fixtures/files/test_img.png", "image/png")
          expect(user.avatar.attached?).to eq false
          patch api_v1_me_path,
                params: { user: update_user },
                headers: payload_headers(uid: user.uid)
          user.reload
          expect(user.avatar.attached?).to eq true
          expect(response).to have_http_status(200)
          expect(parsed_body['avatar']).to eq user.avatar_url
        end
      end
    end
  end

  describe "GET api/v1/me" do
    let!(:user) { create(:user) }

    context "ヘッダーに有効なトークンが存在する場合" do
      it "トークンのユーザーを返すこと" do
        get api_v1_me_path, headers: payload_headers(uid: user.uid)
        expect(response).to have_http_status(200)
        expect(parsed_body['name']).to eq user.name
      end

      context 'アバター画像がアタッチされている場合' do
        before { user.avatar.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_img.png"),
                                    filename: 'test_img.png',
                                    content_type: 'image/png') }
        it 'アバター画像を返すこと' do
          get api_v1_me_path, headers: payload_headers(uid: user.uid)
          expect(response).to have_http_status(200)
        end
      end
    end

    context "ヘッダーにトークンが無い場合" do
      it "401エラーが返ること" do
        get api_v1_me_path
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE api/v1/me" do
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
      end
    end
  end
end
