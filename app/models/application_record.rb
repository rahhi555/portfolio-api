# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def strf_created_at
    created_at.strftime('%Y-%m-%d %H:%M')
  end

  def strf_updated_at
    updated_at.strftime('%Y-%m-%d %H:%M')
  end
end
