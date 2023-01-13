# frozen_string_literal: true

class QueryBuilder
  def initialize(collection)
    @collection = collection
  end

  def query(constraints, operator: :any)
    return collection if constraints.empty?

    scopes = constraints.map do |conditions|
      collection.includes(field_associations: :field).where(conditions)
    end

    case operator
    when :any
      scopes.reduce(&:or)
    when :all
      scopes.reduce(&:merge)
    end
  end

  private

  attr_reader :collection
end
