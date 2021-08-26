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

      def destroy
        ext_current_user.destroy!
        render status: :ok
      end

      def me
        if ext_current_user
          render json: ext_current_user, status: :ok
        else
          render json: { message: "Current user not found" }, status: :unprocessable_entity
        end
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
        @payload ||= if Rails.env.production?
                       FirebaseIdToken::Signature.verify token
                     else
                       JWT.decode(token, nil, false)[0]
                     end
      end
    end
  end
end
