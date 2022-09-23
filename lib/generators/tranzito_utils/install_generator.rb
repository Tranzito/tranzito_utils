# frozen_string_literal: true

require "rails/generators/base"

module TranzitoUtils
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates/", __FILE__)

    # it will copy the tranzito_utils.rb file into the hosts application
    def copy_initializer
      template "tranzito_utils.rb", "config/initializers/tranzito_utils.rb"
    end
  end
end
