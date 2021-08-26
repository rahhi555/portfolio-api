module Api
  module V1
    class ApplicationController < ActionController::API
      include Firebase::Auth::Authenticable
      before_action :authenticate_user, if: proc { Rails.env.production? }


      def ext_current_user
        Rails.env.production? ? current_user : User.find_by(uid: payload['sub'])
      end
    end
  end
end
