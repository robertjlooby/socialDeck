# Load the rails application
require File.expand_path('../application', __FILE__)

# Silence the warnings Heroku creates
ActiveSupport::Deprecation.silenced = true

# Initialize the rails application
Socialdeck::Application.initialize!
