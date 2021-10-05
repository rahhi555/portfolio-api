class PlanChannel < ApplicationCable::Channel
  def subscribed
    @plan = Plan.find(params[:plan_id])
    stream_for @plan

  rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def toggle_todo_status(hash)
    PlanChannel.broadcast_to(@plan, { trigger: 'toggleTodoStatus', id: hash['id'], status: hash['status'] })
  end

  def begin_plan
    PlanChannel.broadcast_to(@plan, { trigger: 'beginPlan' })
  end

  def end_plan
    PlanChannel.broadcast_to(@plan, { trigger: 'endPlan' })
  end
end
