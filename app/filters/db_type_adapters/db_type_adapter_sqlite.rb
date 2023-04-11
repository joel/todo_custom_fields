# frozen_string_literal: true

require_relative "./sqlite/datetime"

module DbTypeAdapters
  class DbTypeAdapterSqlite
    def initialize(field_type, value)
      @field_type = field_type
      @value = value
    end

    delegate :db_placeholder, to: :type_converter

    delegate :target_placeholder, to: :type_converter

    private

    attr_reader :field_type, :value

    def type_converter
      @type_converter ||= "DbTypeAdapters::#{field_type.classify}".constantize.new(value)
    end
  end
end
