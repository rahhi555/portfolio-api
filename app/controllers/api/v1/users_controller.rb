module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: %i[create]

      def show
        user = User.find(params[:id])
        response_success(user)
      end

      def create
        user = User.create!(user_params.merge(uid: payload['sub'],
                                              provider: sign_in_provider))
        response_success(user)
      end

      def update
        current_user.update!(user_params.merge(provider: sign_in_provider))
        render template: 'api/v1/users/me', status: :ok
      end

      def destroy
        user = current_user.destroy!
        render json: { message: 'User successfully deleted.', id: user.id, uid: user.uid, name: user.name }, status: :ok
      end

      def me
        render template: 'api/v1/users/me', status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :avatar)
      end

      def sign_in_provider
        payload['firebase']['sign_in_provider'].slice(/.*[^.com]/)
      end
    end
  end
end
