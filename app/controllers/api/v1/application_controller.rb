module Api
  module V1
    class ApplicationController < ActionController::API
      include Firebase::Auth::Authenticable
      include Api::ExceptionHandler
      include Api::FirebaseAuth
      before_action :authenticate_user

      def ext_current_user
        Rails.env.production? ? current_user : User.find_by!(uid: payload['sub'])
      end
    end
  end
end
