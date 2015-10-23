require 'capybara/rspec'
require File.expand_path("../../config/environment", __FILE__)
#require_relative '../app/models/user'

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |e|
    e.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
