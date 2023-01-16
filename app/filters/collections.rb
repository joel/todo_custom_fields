# frozen_string_literal: true

class Collections
  def initialize(todo)
    @todo = todo
    @obfuscator = Obfuscator.new

    proxy = Module.new

    todo.fields.each do |field|
      proxy.define_method field.identifier.to_s.pluralize do
        with_default_option(
          Item.includes(field_associations: :field).where(todo:).where(field_associations: { field: }).map do |item|
            value = item.field_associations.find_by(field:).value
            [
              value,
              encrypt({ field_associations: { value:, fields: { identifier: field.identifier } } }.to_json)
            ]
          end
        )
      end
    end

    extend proxy
  end

  def names
    @names ||= with_default_option(
      todo.items.map do |item|
        [
          item.name,
          encrypt({ name: item.name }.to_json)
        ]
      end
    )
  end

  delegate :custom_fields, to: :todo
  delegate :encrypt, to: :obfuscator

  private

  attr_reader :todo, :obfuscator

  def with_default_option(items)
    [["Select…", nil], *items]
  end
end
