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

  def toggleTodoStatus(req)
    PlanChannel.broadcast_to(@plan, { action: req['action'], id: req['id'], status: req['status'] })
  end

  def beginPlan(req)
    PlanChannel.broadcast_to(@plan, { action: req['action'] })
  end

  def endPlan(req)
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
