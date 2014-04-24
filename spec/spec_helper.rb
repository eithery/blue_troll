require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/features/shared_examples/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/features/spec_helpers/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/requests/shared_examples/**/*.rb")].each { |f| require f }

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    # Includes Capybara domain specific language.
    config.include Capybara::DSL

    config.include SessionsHelper
    config.include DomainModelMocks
    config.include DomainModelMatchers
    config.include FlashMatchers
    config.include MailerMatchers
    config.include PageMatchers
    config.include ViewMatchers

    config.extend UserAccountMacros
  end
end


Spork.each_run do
end
