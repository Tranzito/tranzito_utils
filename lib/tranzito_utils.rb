# frozen_string_literal: true

module TranzitoUtils
  DEFAULT = {
    earliest_period_time: Time.at(1637388000),
    earliest_year: 1900,
    latest_year: (Time.current.year + 100),
    additional_search_keys: [],
    time_zone: ""
  }
end

require "tranzito_utils/concerns/set_period"
require "tranzito_utils/concerns/sortable_table"
require "tranzito_utils/helpers/graphing_helper"
require "tranzito_utils/helpers/sortable_helper"
require "tranzito_utils/services/time_parser"
require "tranzito_utils/version"
require "tranzito_utils/gem"
