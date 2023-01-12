# frozen_string_literal: true

class Collections
  def initialize(todo)
    @todo = todo

    proxy = Module.new

    todo.fields.each do |field|
      proxy.define_method field.identifier.to_s.pluralize do
        Item.includes(:field_associations).where(todo:).where(field_associations: { field: }).pluck(:value)
      end
    end

    extend proxy
  end

  def names
    @names ||= with_default_option(todo.items.pluck(:name))
  end

  delegate :custom_fields, to: :todo

  private

  attr_reader :todo

  def with_default_option(items)
    [["Select…", nil], *items]
  end
end
