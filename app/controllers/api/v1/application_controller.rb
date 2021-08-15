module Api
  module V1
    class ApplicationController < ActionController::API
      include Firebase::Auth::Authenticable
      before_action :authenticate_user
    end
  end
end
