# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
oauth_environment_variables = File.join(Rails.root, 'config', 'oauth_environment_variables.rb')
load(oauth_environment_variables) if File.exist?(oauth_environment_variables)
Rails.application.initialize!
