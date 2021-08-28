module Api::FirebaseAuth
  extend ActiveSupport::Concern

  def token_from_request_headers
    request.headers['Authorization']&.split&.last
  end

  def token
    params[:token] || token_from_request_headers
  end

  def payload
    @payload ||= FirebaseIdToken::Signature.verify(token, raise_error: true)
  end

end
