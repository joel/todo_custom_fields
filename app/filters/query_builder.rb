# frozen_string_literal: true

class QueryBuilder
  def initialize(collection)
    @collection = collection
  end

  def query(criteria)
    return collection if criteria.empty?

    collection.includes(:field_associations).where(criteria)
  end

  private

  attr_reader :collection
end
