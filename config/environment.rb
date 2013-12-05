# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WorkedHours::Application.initialize!

# Data formatada para visualização
# - %I:%M%p - hora
Time::DATE_FORMATS[:dt_time] = "%d/%m/%Y"
Date::DATE_FORMATS[:dt]      = "%d/%m/%Y"