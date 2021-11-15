module Api
  module V1
    class MapsController < ApplicationController
      def index
        maps = Plan.find(params[:plan_id]).maps.order(:id)
        response_success(maps)
      end

      def create
        map = Plan.find(params[:plan_id]).maps.create!(map_params)
        response_success(map)
      end

      def update
        map = Map.find(params[:id])
        map.update!(map_params)
        response_success(map)
      end

      def destroy
        map = current_user.maps.find(params[:id])
        map.destroy!
        render json: { message: 'Map successfully deleted.', id: map.id, name: map.name }, status: :ok
      end

      private

      def map_params
        params.require(:map).permit(:id, :name, :is_google_map, :address, :heading,
                                    :width, :height, bounds: %i[south north east west])
      end
    end
  end
end
