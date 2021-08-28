module Api
  module V1
    class PlansController < ApplicationController
      def index
        @plans = Plan.all
        render template: 'plans/index', status: :ok
      end

      def create
        plan = Plan.create!(plan_params.merge(user_id: ext_current_user.id))
        render json: plan, status: :ok
      end

      private

      def plan_params
        params.require(:plan).permit(:name)
      end
    end
  end
end
