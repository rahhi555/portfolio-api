module Api::FirebaseAuth
  extend ActiveSupport::Concern

  def token_from_request_headers
    request.headers['Authorization']&.split&.last
  end

  def token
    params[:token] || token_from_request_headers
  end

  def payload
    @payload ||= if Rails.env.production?
                   FirebaseIdToken::Signature.verify!(token)
                 else
                   JWT.decode(token, nil, false)[0]
                 end
  end
end
