require 'mocha'

RSpec.configure do |config|
  config.mock_framework = :mocha
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end