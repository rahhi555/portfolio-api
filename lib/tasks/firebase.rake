namespace :firebase do
  namespace :certificates do
    desc 'Redisが空のときにGoogleのx509証明書を要求する'
    task request: :environment do
      FirebaseIdToken::Certificates.request
    end

    desc 'Redis内のx509証明書を上書きする'
    task force_request: :environment do
      FirebaseIdToken::Certificates.request!
    end
  end
end
