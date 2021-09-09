module Api
  module V1
    class MapsController < ApplicationController
      def index
        @maps = Plan.find(params[:plan_id]).maps
        render template: 'api/v1/maps/index', status: :ok
      end

      def create
        @map = Plan.find(params[:plan_id]).maps.create!(map_params)
        render template: 'api/v1/maps/create', status: :ok
      end

      def update
        map = Map.find(params[:id])
        map.update!(map_params)
        render json: map, status: :ok
      end

      def destroy
        map = current_user.maps.find(params[:id])
        map.destroy!
        render json: { message: 'Map successfully deleted.', id: map.id, name: map.name }, status: :ok
      end

      private

      def map_params
        params.require(:map).permit(:name)
      end
    end
  end
end
