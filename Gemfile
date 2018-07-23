source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'

gem 'haml'
gem 'haml-rails', group: :development

gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'bootstrap-will_paginate'

gem 'bcrypt', '~> 3.1.7'
gem 'enumerate_it'
gem 'will_paginate'

gem 'delayed_job_active_record'
gem 'delayed_mailhopper'
gem 'barby'
gem 'prawn'
gem 'rubyzip'

gem 'tzinfo-data'
gem 'sdoc', group: :doc


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end


group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end


group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'factory_girl_rspec'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'shoulda-kept-respond-with-content-type'
end
