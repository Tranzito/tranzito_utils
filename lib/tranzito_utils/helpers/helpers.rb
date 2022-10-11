# frozen_string_literal: true

module TranzitoUtils
  module Helpers
    include TranzitoUtils::SortableHelper
    include TranzitoUtils::GraphingHelper

    def in_admin?
      controller_namespace == "admin"
    end

    def page_title
      return @page_title if defined?(@page_title)
      prefix = (in_admin? ? "🧰" : TranzitoUtils::DEFAULT[:application_display_name])
      return "#{prefix} #{@prefixed_page_title}" if @prefixed_page_title.present?
      [
        prefix,
        default_action_name_title,
        controller_title_for_action
      ].compact.join(" ")
    end

    def active_link(link_text, link_path, html_options = {})
      match_controller = html_options.delete(:match_controller)
      html_options[:class] ||= ""
      html_options[:class] += " active" if current_page_active?(link_path, match_controller)
      link_to(raw(link_text), link_path, html_options).html_safe
    end

    def current_page_active?(link_path, match_controller = false)
      link_path = Rails.application.routes.recognize_path(link_path)
      active_path = Rails.application.routes.recognize_path(request.url)
      matches_controller = active_path[:controller] == link_path[:controller]
      return true if match_controller && matches_controller
      current_page?(link_path) || matches_controller && active_path[:action] == link_path[:action]
    rescue # This mainly fails in testing - but why not rescue always
      false
    end

    def current_user_time_preference_script
      time_preference = current_user&.time_preference || User.time_preferences.first
      scrpt = ""
      if %w[single_format_local single_format_event].include?(time_preference)
        scrpt += "window.timeParserSingleFormat=true;"
      end
      if %w[single_format_event variable_format_event].include?(time_preference)
        scrpt += 'window.localTimezone="America/Los_Angeles";'
      end
      scrpt
    end

    def pretty_print_json(data)
      require "coderay"
      CodeRay.scan(JSON.pretty_generate(data), :json).div.html_safe
    end

    private

    def default_action_name_title
      if action_name == "show"
        # Take up less space for admin
        return in_admin? ? nil : "Display"
      end
      action_name == "index" ? nil : action_name.titleize
    end

    def controller_title_for_action
      return @controller_display_name if defined?(@controller_display_name)
      # No need to include parking
      c_name = controller_name.gsub("parking_location", "location")
      return c_name.titleize if %(index).include?(action_name)
      c_name.singularize.titleize
    end
  end
end
