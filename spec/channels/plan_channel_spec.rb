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

    context 'toggleTodoStatus' do
      it 'todoのステータスがブロードキャストされること' do
        expect {
          perform :toggleTodoStatus, { id: 1, status: 'done' }
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'toggleTodoStatus'
          expect(data['id']).to eq 1
          expect(data['status']).to eq 'done'
        }
      end
    end

    context 'beginPlan' do
      it 'action => begin_planがブロードキャストされること' do
        expect {
          perform :beginPlan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'beginPlan'
        }
      end
    end

    context 'end_plan' do
      it 'action => endPlanがブロードキャストされること' do
        expect {
          perform :endPlan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['action']).to eq 'endPlan'
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
