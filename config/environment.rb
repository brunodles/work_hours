# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WorkedHours::Application.initialize!

# Data formatada para visualização
# - %I:%M%p - hora
Time::DATE_FORMATS[:dt_time]           = "%d/%m/%Y"
Date::DATE_FORMATS[:dt]                = "%d/%m/%Y"
Date::DATE_FORMATS[:dt_with_time]      = "%d/%m/%Y às %H:%M"
Time::DATE_FORMATS[:dt_time_with_time] = "%d/%m/%Y às %H:%M"
