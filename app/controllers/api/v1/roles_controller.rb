module Api
  module V1
    class RolesController < ApplicationController
      def index
        roles = Role.all
        render json: roles, status: :ok
      end

      def create
        role = Role.create!(role_params)
        render json: role, status: :ok
      end

      def update
        role = Role.find(params[:id])
        role.update!(role_params)
        render json: role, status: :ok
      end

      def destroy
        role = Role.find(params[:id])
        role.destroy!
        render json: { message: 'Role successfully deleted.', id: role.id, name: role.name }, status: :ok
      end

      private

      def role_params
        params.require(:role).permit(:name, :plan_id)
      end
    end
  end
end
