ENV['RACK_ENV'] = 'test'

require_relative '../boot'

RSpec.configure do |config|
  config.order = 'random'
end