# frozen_string_literal: true

class Collections
  def initialize(todo)
    @todo = todo
  end

  def names
    @names ||= with_default_option(todo.items.pluck(:name))
  end

  private

  attr_reader :todo

  def with_default_option(items)
    [["Select…", nil], *items]
  end
end
