source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.7'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'redis', '~> 4.0'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'firebase-auth-rails'
gem 'whenever', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors'
gem 'jb'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rbs', require: false
  gem 'rbs_rails', require: false
  gem 'steep', require: false
  gem 'typeprof', require: false
  gem 'bullet'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
