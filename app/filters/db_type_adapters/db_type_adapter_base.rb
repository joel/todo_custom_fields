# frozen_string_literal: true

module DbTypeAdapters
  class DbTypeAdapterBase
    def db_placeholder
      raise NotImplementedError
    end

    def target_placeholder
      raise NotImplementedError
    end
  end
end
