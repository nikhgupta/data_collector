require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_custom do |app|
  Capybara::Poltergeist::Driver.new(
    app, js_errors: false, timeout: 10000, window_size: [1400, 1000],
    phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes']
  )
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :poltergeist_custom

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include ApiHelper
  config.include IntegrationHelpers
  config.include FactoryGirl::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include Warden::Test::Helpers, type: :request

  config.before(:suite) do
    FactoryGirl.lint
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    travel_back
  end
end
