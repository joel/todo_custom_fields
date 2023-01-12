# frozen_string_literal: true

module Filtering
  def filter(collection, criteria)
    resources = collection.ransack(criteria)

    block_given? ? yield(resources) : resources
  end
end
