# ApplicationRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def camelize_keys
    attributes.transform_keys! { |key| key.camelize(:lower) }
  end

  def self.camelize_keys
    all.map(&:camelize_keys)
  end
end
