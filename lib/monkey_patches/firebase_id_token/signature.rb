# 開発環境だとエミュレーターのfirebaseJWTが弾かれるためモンキーパッチを当てる
require 'firebase_id_token'
unless FirebaseIdToken::VERSION == "2.4.0"
  raise 'モンキーパッチ作成時とバージョンが異なります。このパッチを削除することを検討してください'
end

# 本番環境なら本来の挙動を、開発環境なら検証はせずそのままJWTをデコードする
module FirebaseIdTokenSignaturePatch
  def verify(jwt_token, raise_error: false)
    if Rails.env.production?
      super
    else
      JWT.decode(jwt_token, nil, false)[0]
    end
  end
end

FirebaseIdToken::Signature.singleton_class.prepend(FirebaseIdTokenSignaturePatch)
