require File.expand_path("#{File.dirname(__FILE__)}/environment")

set :environment, Rails.env.to_sym

set :output, "#{Rails.root}/log/cron.log"

# crontab生存確認用
every 1.hours do
  command 'echo $(date)'
end

# firebase証明書を1時間おきに取得
every 1.hours do
  rake 'firebase:certificates:force_request'
end

# activeにして一日経過した計画をinactivateする
every 1.day, at: '3:00 am' do
  rake 'plans:inactivate_plans_since_yesterday'
end
