# frozen_string_literal: true

module QueryFragments
  class QueryFragmentDatetime
    def initialize(value)
      @value = value
    end

    def db_placeholder
      "datetime(substr(field_associations.value, 1, 19))"
    end

    def target_placeholder
      "datetime('#{@value.strftime("%Y-%m-%d %H:%M:%S")}')"
    end
  end
end
