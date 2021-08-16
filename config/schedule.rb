require File.expand_path("#{File.dirname(__FILE__)}/environment")

set :environment, Rails.env.to_sym

set :output, "#{Rails.root}/log/cron.log"

every 1.hours do
  rake 'firebase:certificates:force_request'
end

every 1.hours do
  command "echo $(date)"
end
