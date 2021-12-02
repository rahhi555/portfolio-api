class PlanChannel < ApplicationCable::Channel
  def subscribed
    @plan = Plan.find(params[:plan_id])
    stream_for @plan
  rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed
    stop_all_streams
  end

  def changeTodoStatus(req)
    req['id']
    todo_status = TodoStatus.find(req['id'])
    todo_status.update!(status: req['status'])
    PlanChannel.broadcast_to(@plan, { action: req['action'], id: req['id'], status: req['status'] })
  end

  def activatePlan(req)
    reject if @plan.active?

    todo_statuses = @plan.activate
    PlanChannel.broadcast_to(@plan, { action: req['action'], todoStatuses: todo_statuses })
  end

  def inactivatePlan(req)
    reject unless @plan.active?

    @plan.inactivate
    PlanChannel.broadcast_to(@plan, { action: req['action'] })
  end

  def sendActiveSvg(req)
    PlanChannel.broadcast_to(@plan, { action: req['action'], svg: req['svg'] })
  end

  def sendCurrentPosition(req)
    PlanChannel.broadcast_to(@plan,
                             { action: req['action'], userId: req['userId'], lat: req['lat'], lng: req['lng'],
                               name: req['name'] })
  end
end
