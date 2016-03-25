# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'

# Add additional requires below this line. Rails is not loaded until this point!
require 'shoulda/matchers'

# Requires supporting ruby files with custom matchers and macros, etc.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!


  # Temporary workaround to the issue with controller specs.
  config.include Rails::Controller::Testing::TestProcess
  config.include Rails::Controller::Testing::TemplateAssertions
  config.include Rails::Controller::Testing::Integration

  config.include DomainModelMocks
  config.include DomainModelMatchers
  config.include FlashMatchers
  config.include MailerMatchers
  config.include PageMatchers
  config.include ViewMatchers
  config.extend UserAccountMacros
end


Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end


Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url("fonts.googleapis.com")
end
