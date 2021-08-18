# ALBのヘルスチェック用コントローラー
class HealthCheckController < ActionController::API
  def health_check
    render plain: 'health check api ok', status: :ok
  end
end
