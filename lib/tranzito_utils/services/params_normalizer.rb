# frozen_string_literal: true

module TranzitoUtils
  module ParamsNormalizer
    def self.boolean(param = nil)
      return false if param.blank?
      ActiveRecord::Type::Boolean.new.cast(param.to_s.strip)
    end
  end
end
