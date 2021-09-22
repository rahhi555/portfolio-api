module Api
  module V1
    class TodoListsController < ApplicationController
      def index
        @todo_lists = Plan.find(params[:plan_id]).todo_lists.includes(:todos)
        render template: 'api/v1/todo_lists/index', status: :ok
      end

      def create
        @todo_list = Plan.find(params[:plan_id]).todo_lists.create!(todo_list_params)
        render template: 'api/v1/todo_lists/create', status: :ok
      end

      def update
        @todo_list = TodoList.find(params[:id])
        @todo_list.update!(todo_list_params)
        render template: 'api/v1/todo_lists/update', status: :ok
      end

      def destroy
        todo_list = TodoList.find(params[:id]).destroy!
        response_success(todo_list)
      end

      private

      def todo_list_params
        params.require(:todo_list).permit(:title)
      end
    end
  end
end
