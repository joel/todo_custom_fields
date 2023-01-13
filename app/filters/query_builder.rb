# frozen_string_literal: true

class QueryBuilder
  def initialize(collection)
    @collection = collection
  end

  def query(constraints)
    return collection if constraints.empty?

    collection_ids = constraints.each_with_object([]) do |conditions, sub_sets|
      sub_sets << collection.includes(field_associations: :field).where(conditions).pluck(:id)

      sub_sets << (sub_sets.pop & sub_sets.pop) if sub_sets.size == 2
    end.flatten

    collection.where(id: collection_ids)
  end

  private

  attr_reader :collection
end
