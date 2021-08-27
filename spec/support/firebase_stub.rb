module FirebaseStub
  def stub_firebase(user)
    allow_any_instance_of(Firebase::Auth::Authenticable).to receive(:authenticate_entity).and_return(user)
  end

  def payload_headers(uid: nil)
    FirebaseIdToken.test!
    payload = JSON.parse File.read("#{Rails.root}/spec/factories/files/payload.json")
    payload['sub'] = uid if uid
    payload = JWT.encode payload, OpenSSL::PKey::RSA.new(FirebaseIdToken::Testing::Certificates.private_key), 'RS256'
    { Authorization: "Bearer #{payload}" }
  end
end