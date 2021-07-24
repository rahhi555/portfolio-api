# ALBのヘルスチェック用コントローラー
class HealthCheckController < ApplicationController
  def health_check
    render plain: 'health check ok', status: :ok
  end
end
