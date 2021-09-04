module Api
  module V1
    class RolesController < ApplicationController
      before_action :set_plan, only: %i[index create]

      def index
        @roles = @plan.roles
        render template: 'api/v1/roles/index', status: :ok
      end

      def create
        role = @plan.roles.create!(role_params)
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
        params.require(:role).permit(:name, :description)
      end

      def set_plan
        @plan = Plan.find(params[:plan_id])
      end
    end
  end
end
