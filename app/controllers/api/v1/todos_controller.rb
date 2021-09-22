module Api
  module V1
    class TodosController < ApplicationController
      def index
        @todos = TodoList
                 .find(params[:todo_list_id])
                 .todos
                 .with_attached_images
                 .order(:id)
        render template: 'api/v1/todos/index', status: :ok
      end

      def show
        @todo = Todo.with_attached_images.find(params[:id])
        @column = params[:column]
        render template: 'api/v1/todos/show', status: :ok
      end

      def create
        @todo = TodoList.find(params[:todo_list_id]).todos.create!(todo_params)
        render template: 'api/v1/todos/update', status: :ok
      end

      def update
        @todo = Todo.find(params[:id])
        @todo.update!(todo_params)
        render template: 'api/v1/todos/update', status: :ok
      end

      def destroy
        todo = Todo.find(params[:id])
        todo.destroy!
        response_success(todo)
      end

      private

      def todo_params
        params.require(:todo).permit(:title, :body, :begin_time, :end_time, :status, images: [])
      end
    end
  end
end
