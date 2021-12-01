require 'rails_helper'

RSpec.describe PlanChannel, type: :channel do
  let!(:plan) { create(:plan) }

  it '正しい属性値の場合、サブスクライブに成功すること' do
    subscribe plan_id: plan.id
    expect(subscription).to be_confirmed
  end

  it '属性値がない場合、rejectが返ってくること' do
    subscribe
    expect(subscription).to be_rejected
  end

  describe '各種メソッド' do
    before { subscribe plan_id: plan.id }

    context 'changeTodoStatus' do
      let!(:todo_status) { create(:todo_status) }

      it 'todoステータスが更新され、ブロードキャストされること' do
        expect {
          perform :changeTodoStatus, { id: todo_status.id, status: 'done' }
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'changeTodoStatus'
          expect(data['id']).to eq todo_status.id
          expect(data['status']).to eq 'done'
        }.and change{ todo_status.reload.status }.to('done')
      end
    end

    context 'activatePlan' do
      include_context 'Plan Activate default values setup'

      it 'action => activatePlan及びtodoStatusesがブロードキャストされること' do
        expect {
          perform :activatePlan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'activatePlan'
          expect(data['todoStatuses'].length).to eq todo_statuses_length
        }
      end
    end

    context 'inactivatePlan' do
      it 'action => inactivatePlanがブロードキャストされること' do
        expect {
          perform :inactivatePlan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'inactivatePlan'
        }
      end
    end

    context 'sendActiveSvg' do
      let(:user) { create(:user) }

      it 'pathがブロードキャストされること' do
        MAX_SAFE_INTEGER = 9_007_199_254_740_991
        MIN_ACTIVE_PATH_ID = 1_000_000_000_000_000
        path = {
          "id" => rand(MAX_SAFE_INTEGER..MAX_SAFE_INTEGER),
          "type" => 'Path',
          "userId" => user.id,
          "x" => 100,
          "y" => 100,
          "displayTime" => 4000,
          "drawPoints" =>
            "M44.5 15c0-8.271-6.729-15-15-15s-15 6.729-15 15c0 7.934 6.195 14.431 14 14.949v4.429c0 .553.448 3.56 1 3.56s1-3.007 1-3.56v-4.429c7.805-.518 14-7.015 14-14.949Z",
        }
        expect {
          perform :sendActiveSvg, { svg: path }
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'sendActiveSvg'
          expect(data['svg']).to eq path
        }
      end
    end

    context 'sendCurrentPosition' do
      it 'lat,lng及びuserIdがブロードキャストされること' do
        expect {
          perform :sendCurrentPosition, { userId: 1, lat: 90, lng: 180, name: 'user_1' }
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'sendCurrentPosition'
          expect(data['userId']).to eq 1
          expect(data['lat']).to eq 90
          expect(data['lng']).to eq 180
          expect(data['name']).to eq 'user_1'
        }
      end
    end
  end
end
