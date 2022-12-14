# frozen_string_literal: true

module TranzitoUtils
  module AdminHelper
    def admin_number_display(number)
      content_tag(:span, number_with_delimiter(number), class: ((number == 0) ? "less-less-strong" : ""))
    end
  end
end
