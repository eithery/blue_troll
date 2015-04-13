require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/collection_matchers'
  require 'rspec/its'
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.infer_spec_type_from_file_location!
    config.order = "random"

    config.expect_with :rspec do |c|
      c.syntax = [:should, :expect]
    end
    config.mock_with :rspec do |mocks|
      mocks.syntax = [:should, :expect]
    end

    # Includes Capybara domain specific language.
    config.include Capybara::DSL

    config.include SessionsHelper, type: :view

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
