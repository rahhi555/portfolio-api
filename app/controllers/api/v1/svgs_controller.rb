module Api
  module V1
    class SvgsController < ApplicationController
      def index
        svgs = Plan.find(params[:plan_id]).svgs.order(:display_order)
        response_success(svgs)
      end

      def create
        map = Map.find(params[:map_id])
        svg = map.svgs.create!(svg_params.merge(user_id: current_user.id))
        response_success(svg)
      end

      def update
        svg = Svg.find(params[:id])
        svg.update!(svg_params)
        response_success(svg)
      end

      def destroy
        svg = Svg.find(params[:id])
        svg.destroy!
        render json: { message: 'SVG successfully deleted.', id: svg.id, name: svg.name }, status: :ok
      end

      private

      def svg_params
        params.require(:svg).permit(:id, :x, :y, :fill, :stroke, :name, :display_order, :width, :height, :display_time,
                                    :draw_points, :type, :todo_list_id, :user_id)
      end
    end
  end
end
