# frozen_string_literal: true

class Collections
  def initialize(todo)
    @todo = todo

    proxy = Module.new

    todo.fields.each do |field|
      proxy.define_method field.identifier.to_s.pluralize do
        Item.includes(field_associations: :field).where(todo:).where(field_associations: { field: }).map do |item|
          value = item.field_associations.find_by(field:).value
          [
            value,
            { field_associations: { value:, fields: { identifier: field.identifier } } }.to_json
          ]
        end
      end
    end

    extend proxy
  end

  def names
    @names ||= with_default_option(
      todo.items.map do |item|
        [
          item.name,
          { name: item.name }.to_json
        ]
      end
    )
  end

  delegate :custom_fields, to: :todo

  private

  attr_reader :todo

  def with_default_option(items)
    [["Select…", nil], *items]
  end
end
