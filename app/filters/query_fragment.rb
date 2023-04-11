# frozen_string_literal: true

class QueryFragment
  def initialize(options)
    @identifier     = options.fetch(:identifier)
    @value          = options.fetch(:value)
    @field_type     = options.fetch(:field_type)
    @query_template = options.fetch(:query)
  end

  def query
    query = query_template

    querifier = "QueryFragments::QueryFragment#{field_type.classify}".constantize.new(value)

    [
      query.gsub(":db_placeholder", querifier.db_placeholder).gsub(":target_placeholder", querifier.target_placeholder),
      {
        identifier:
      }
    ]
  end

  private

  attr_reader :identifier, :value, :field_type, :query_template
end
