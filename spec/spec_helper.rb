require './app'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'ip_monitoring_test'
)

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
