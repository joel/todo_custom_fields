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

    [
      query.gsub(":db_placeholder", db_placeholder).gsub(":target_placeholder", target_placeholder),
      {
        datetime: value.strftime("%Y-%m-%d %H:%M:%S"),
        identifier:
      }
    ]
  end

  private

  def db_placeholder
    "datetime(substr(field_associations.value, 1, 19))"
  end

  def target_placeholder
    "datetime(:datetime)"
  end

  attr_reader :identifier, :value, :field_type, :query_template
end
