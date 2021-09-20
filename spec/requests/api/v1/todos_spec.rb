require 'rails_helper'

RSpec.describe "Api::V1::Todos", type: :request do
  let(:user) { create(:user) }
  let(:valid_header) { payload_headers(uid: user.uid) }
  let(:todo_list) { create(:todo_list) }

  describe "GET /api/v1/todo_lists/:todo_list_id/todos" do
    let!(:todos) { create_list(:todo, 3, todo_list_id: todo_list.id) }
    let!(:another_todos) { create_list(:todo, 2) }
    it 'Todoが取得できること' do
      get api_v1_todo_list_todos_path(todo_list.id), headers: valid_header
      expect(response).to have_http_status(200)
      expect(parsed_body.size).to eq todos.size
    end

    context '画像が複数アタッチされている場合' do
      let(:todo) { create(:todo) }
      before {
        2.times do
          todo.images.attach(io: File.open("#{Rails.root}/spec/fixtures/files/test_img.png"),
                                      filename: 'test_img.png',
                                      content_type: 'image/png')
        end
      }
      it 'すべての画像を返すこと' do
        get api_v1_todo_list_todos_path(todo.todo_list_id), headers: payload_headers(uid: user.uid)
        expect(response).to have_http_status(200)
        expect(parsed_body[0]['images'].size).to eq 2
      end
    end
  end

  describe "POST /api/v1/todo_lists/:todo_list_id/todos" do
    let(:todo) { attributes_for(:todo) }

    it "Todoが作成できること" do
      expect {
        post api_v1_todo_list_todos_path(todo_list.id), params: { todo: todo }, headers: valid_header
      }.to change{ Todo.count }.by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /api/v1/todos/:id" do
    let(:todo) { create(:todo) }
    let(:update_attr) { { title: 'new title' } }

    it "Todoが更新できること" do
      patch api_v1_todo_path(todo.id), params: { todo: update_attr }, headers: valid_header
      expect(response).to have_http_status(200)
      expect(parsed_body['title']).to eq update_attr[:title]
    end

    it 'アバター画像を複数アタッチできること' do
      image = Rack::Test::UploadedFile.new("spec/fixtures/files/test_img.png", "image/png")
      update_attr[:images] = [ image, image ]
      expect(todo.images.attached?).to eq false
      patch api_v1_todo_path(todo.id),
            params: { todo: update_attr },
            headers: valid_header
      todo.reload
      expect(todo.images.attached?).to eq true
      expect(response).to have_http_status(200)
      expect(parsed_body['images']).to eq todo.image_urls
    end
  end

  describe "DELETE /api/v1/todos/:id" do
    let!(:todo) { create(:todo) }

    it "Todoを削除できること" do
      expect {
        delete api_v1_todo_path(todo.id), headers: valid_header
      }.to change{ Todo.count }.by(-1)
      expect(response).to have_http_status(200)
      expect(parsed_body['id']).to eq todo.id
    end
  end

end
