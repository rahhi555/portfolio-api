require 'rails_helper'

RSpec.describe "HealthCheck", type: :request do
  it '/health-checkにGETでアクセスしたら200が返ってくる' do
    get health_check_path
    expect(response).to have_http_status(200)
    expect(response.body).to eq 'health check api ok'
  end
end
