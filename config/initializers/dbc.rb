require 'dbc-ruby'

DBC.client.configure. do |config|
  config.token = ENV['DBC_API']
end
