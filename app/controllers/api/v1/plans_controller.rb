module Api
  module V1
    class PlansController < ApplicationController
      def index
        @plans = Plan.all.includes(%i[user members])
        render template: 'api/v1/plans/index', status: :ok
      end

      def show
        @plan = Plan.find(params[:id])
        render template: 'api/v1/plans/show', status: :ok
      end

      def create
        @plan = Plan.create!(plan_params.merge(user_id: current_user.id))
        render template: 'api/v1/plans/show', status: :ok
      end

      def destroy
        plan = current_user.plans.find(params[:id]).destroy!
        render json: { message: 'Plan successfully deleted.', id: plan.id, name: plan.name }, status: :ok
      end

      private

      def plan_params
        params.require(:plan).permit(:name, :published)
      end
    end
  end
end
