source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'mysql2', '>= 0.4.4'
gem "puma", ">= 4.3.9"
gem 'rails', '~> 6.0.3', '>= 6.0.3.7'
gem 'redis', '~> 4.0'
gem 'image_processing', '~> 1.2'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'firebase-auth-rails'
gem 'jb'
gem 'rack-cors'
gem 'whenever', require: false
gem 'oj'
gem 'json-schema'

group :development, :test do
  gem 'awesome_print'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rbs', require: false
  gem 'rbs_rails', require: false
  gem 'rspec-rails'
  gem 'steep', require: false
  gem 'typeprof', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
