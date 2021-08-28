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
    end
  end
end
