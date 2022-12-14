module TranzitoUtils
  class Gem < Rails::Engine
    initializer "tranzito_utils.config", before: :load_config_initializers do |app|
      # Setting the default timezone for timeparser service from host application configuration
      TranzitoUtils::DEFAULT[:time_zone] = ActiveSupport::TimeZone[Rails.application.config.time_zone]

      # Setting the default application display name
      TranzitoUtils::DEFAULT[:application_display_name] = Rails.application.class.module_parent.to_s
    end
  end
end
