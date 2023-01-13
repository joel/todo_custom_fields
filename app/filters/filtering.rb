# frozen_string_literal: true

module Filtering
  def filter(raw_collection, conditions)
    filtered_collection = QueryBuilder.new(raw_collection).query(conditions)

    block_given? ? yield(filtered_collection) : filtered_collection
  end
end
