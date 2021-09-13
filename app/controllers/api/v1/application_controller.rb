module Api
  module V1
    class ApplicationController < ActionController::API
      include Firebase::Auth::Authenticable
      include Api::ExceptionHandler
      include Api::FirebaseAuth
      before_action :authenticate_user, :snakeize_params

      def response_success(attr)
        render json: attr.camelize_keys, status: :ok
      end

      private

      def snakeize_params
        params.deep_snakeize!
      end
    end
  end
end
