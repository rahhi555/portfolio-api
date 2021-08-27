module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: %i[create]

      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      end

      def create
        user = User.create!(user_params.merge(uid: payload['sub']))
        render json: user, status: :ok
      end

      def destroy
        user = ext_current_user.destroy!
        render json: { message: 'User successfully deleted.', id: user.id, uid: user.uid, name: user.name }, status: :ok
      end

      def me
        render json: ext_current_user, status: :ok
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
                       FirebaseIdToken::Signature.verify!(token)
                     else
                       JWT.decode(token, nil, false)[0]
                     end
      end
    end
  end
end
