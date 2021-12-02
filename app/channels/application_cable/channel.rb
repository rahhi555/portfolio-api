module ApplicationCable
  class Channel < ActionCable::Channel::Base
    rescue_from RuntimeError, with: :reject
  end
end
