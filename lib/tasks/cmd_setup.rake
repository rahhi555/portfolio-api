namespace :cmd do
  desc 'crondの起動とrails sを実行する。dockerのcmdに登録する。'
  task setup: :environment do
    sh 'crond -b'
    sh "bundle exec rails s -b '0.0.0.0'"
  end
end
