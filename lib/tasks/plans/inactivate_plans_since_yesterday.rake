namespace :plans do
  desc 'activateしてから一日経過した計画をinactivateする'
  task inactivate_plans_since_yesterday: :environment do
    Plan.where(active: true, updated_at: ..1.day.ago).map(&:inactivate)
  end
end
