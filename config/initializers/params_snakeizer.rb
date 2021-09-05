module ActionController
  class Parameters
    def deep_snakeize!
      @parameters.deep_transform_keys!(&:underscore)
      self
    end
  end
end
