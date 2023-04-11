# frozen_string_literal: true

class QueryFragment
  def initialize(options)
    @identifier      = options.fetch(:identifier)
    @query_template  = options.fetch(:query)
    @db_type_adapter = DbTypeAdapter.new(options.fetch(:field_type), options.fetch(:value))
  end

  def query
    [
      query_template
        .gsub(":db_placeholder", db_type_adapter.db_placeholder)
        .gsub(":target_placeholder", db_type_adapter.target_placeholder),
      {
        identifier:
      }
    ]
  end

  private

  attr_reader :identifier, :query_template, :db_type_adapter
end
