module Api
  module V1
    class TodoStatusesController < ApplicationController
      def index
        plan = Plan.find(params[:plan_id])
        plans = TodoStatus.where(svg_id: plan.svg_ids)
        response_success(plans)
      end
    end
  end
end
