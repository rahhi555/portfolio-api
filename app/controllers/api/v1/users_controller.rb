module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: %i[create]

      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      end

      def create
        raise ArgumentError, 'BadRequest Parameter' if payload.blank?

        user = User.create!(user_params.merge(uid: payload['sub']))
        render json: user, status: :ok
      end

      def me
        render json: current_user, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name)
      end

      def token_from_request_headers
        request.headers['Authorization']&.split&.last
      end

      def token
        params[:token] || token_from_request_headers
      end

      def payload
        @payload ||= FirebaseIdToken::Signature.verify token
      end
    end
  end
end
