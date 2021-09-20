module Api
  module V1
    class TodosController < ApplicationController
      def index
        todos = TodoList.find(params[:todo_list_id]).todos
        response_success(todos)
      end

      def create
        todo = TodoList.find(params[:todo_list_id]).todos.create!(todo_params)
        response_success(todo)
      end

      def update
        todo = Todo.find(params[:id])
        todo.update!(todo_params)
        response_success(todo)
      end

      def destroy
        todo = Todo.find(params[:id])
        todo.destroy!
        response_success(todo)
      end

      private

      def todo_params
        params.require(:todo).permit(:title, :body, :begin_time, :end_time, :status)
      end
    end
  end
end
