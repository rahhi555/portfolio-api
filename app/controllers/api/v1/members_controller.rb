module Api
  module V1
    class MembersController < ApplicationController
      def index
        @members = Plan
                   .find(params[:plan_id])
                   .members
                   .includes([:role, :user, user: { avatar_attachment: :blob }])
                   .order(:id)

        render template: 'api/v1/members/index', status: :ok
      end

      def create
        @member = Plan.find(params[:plan_id]).members.build(member_params)
        @member.save!
        render template: 'api/v1/members/show', status: :ok
      end

      def update
        @member = Member.find(params[:id])
        @member.update!(member_params)
        render template: 'api/v1/members/show', status: :ok
      end

      def destroy
        member = current_user.members.find(params[:id])
        raise ActiveRecord::RecordInvalid if member.author?

        member.destroy!
        render json: { message: 'Member successfully deleted.', id: member.id }, status: :ok
      end

      private

      def member_params
        params.require(:member).permit(:user_id, :role_id, :accept)
      end
    end
  end
end
