require 'rails_helper'

RSpec.describe "Api::V1::TodoLists", type: :request do
  let(:plan) { create(:plan) }
  let(:valid_header) { payload_headers(uid: plan.user.uid) }

  describe "GET /api/v1/plans/:plan_id/todo_lists" do
    let!(:todo_lists) { create_list(:todo_list, 3, plan_id: plan.id) }
    let!(:another_todo_lists) { create_list(:todo_list, 2) }
    let!(:todos) { create_list(:todo, 3, todo_list_id: todo_lists.first.id) }

    before do
      todos.each do |todo|
        attach_file(todo)
      end
    end

    it '指定した計画のみのTodoリスト一覧を取得できること' do
      get api_v1_plan_todo_lists_path(plan.id), headers: valid_header
      expect(response).to have_http_status(200)
      expect(parsed_body.size).to eq 3
      expect(parsed_body[0]['todos'].size).to eq 3
    end
  end

  describe "POST /api/v1/plans/:plan_id/todo_lists" do
    let(:todo_list) { attributes_for(:todo_list) }
    it 'Todoリストを作成できること' do
      expect {
        post api_v1_plan_todo_lists_path(plan.id), params: { todo_list: todo_list }, headers: valid_header
      }.to change{ TodoList.count }.by(1)
      expect(response).to have_http_status(200)
      expect(parsed_body['name']).to eq todo_list['name']
    end
  end

  describe "PATCH /api/v1/todo_lists/:id" do
    let(:todo_list) { create(:todo_list) }
    let!(:todos) { create_list(:todo, 3, todo_list_id: todo_list.id) }

    before do
      2.times { attach_file(todos.first) }
    end

    it 'Todoリストを更新できること' do
      params = { title: 'new title' }
      patch api_v1_todo_list_path(todo_list.id),
            params: { todo_list: params },
            headers: valid_header
      expect(response).to have_http_status(200)
      expect(parsed_body['title']).to eq params[:title]
      expect(parsed_body['todos'].size).to eq todos.size
      expect(parsed_body['todos'][0]['images'].size).to eq 2
    end
  end

  describe "DELETE /api/v1/todo_lists/:id" do
    let!(:todo_list) { create(:todo_list) }
    it 'Todoリストを削除できること' do
      expect {
        delete api_v1_todo_list_path(todo_list.id), headers: valid_header
      }.to change{ TodoList.count }.by(-1)
      expect(response).to have_http_status(200)
    end
  end

end
