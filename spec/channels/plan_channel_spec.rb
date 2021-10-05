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

    context 'toggle_todo_status' do
      it 'todoのステータスがブロードキャストされること' do
        expect {
          perform :toggle_todo_status, { id: 1, status: 'done' }
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['trigger']).to eq 'toggleTodoStatus'
          expect(data['id']).to eq 1
          expect(data['status']).to eq 'done'
        }
      end
    end

    context 'begin_plan' do
      it 'status => beginPlanがブロードキャストされること' do
        expect {
          perform :begin_plan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['trigger']).to eq 'beginPlan'
        }
      end
    end

    context 'end_plan' do
      it 'status => endPlanがブロードキャストされること' do
        expect {
          perform :end_plan
        }.to have_broadcasted_to(@subscription.instance_variable_get(:@_streams)[0]).with { |data|
          expect(data['trigger']).to eq 'endPlan'
        }
      end
    end
  end
end
