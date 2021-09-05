module Api
  module V1
    class MembersController < ApplicationController
      def index
        @members = Plan.find(params[:plan_id]).members.includes(%i[user role])

        render template: 'api/v1/members/index', status: :ok
      end

      def create
        member = Plan.find(params[:plan_id]).members.build(member_params)
        member.save!
        render json: member, status: :ok
      end

      def destroy
        member = current_user.members.find(params[:id]).destroy!
        render json: { message: 'Member successfully deleted.', id: member.id }, status: :ok
      end

      private

      def member_params
        params.require(:member).permit(:user_id, :role_id, :accept)
      end
    end
  end
end
