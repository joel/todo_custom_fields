# frozen_string_literal: true

module DbTypeAdapters
  module Sqlite
    class Datetime < DbTypeAdapterBase
      def initialize(value)
        super()

        @value = value
      end

      def db_placeholder
        "datetime(substr(field_associations.value, 1, 19))"
      end

      def target_placeholder
        "datetime('#{value}')"
      end

      private

      def value
        @value.strftime("%Y-%m-%d %H:%M:%S")
      end
    end
  end
end
