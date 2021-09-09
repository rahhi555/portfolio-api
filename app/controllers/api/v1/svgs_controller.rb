module Api
  module V1
    class SvgsController < ApplicationController
      def index
        svgs = set_map_svgs
        render json: svgs, status: :ok
      end

      def create
        svg = set_map_svgs.create!(svg_params)
        render json: svg, status: :ok
      end

      def update
        svg = set_svg
        svg.update!(svg_params)
        render json: svg, status: :ok
      end

      def destroy
        svg = set_svg.destroy!
        render json: { message: 'SVG successfully deleted.', id: svg.id, name: svg.name }, status: :ok
      end

      private

      def set_svg
        type = params[:type].classify
        type.constantize.find(params[:id])
      end

      def set_map_svgs
        type = params[:type]
        Map.find(params[:map_id]).send(type)
      end

      def svg_params
        type = params[:type].singularize
        params.require(type).permit(:x, :y, :fill, :stroke, :name, :width, :height, :display_time, :draw_points)
      end
    end
  end
end
