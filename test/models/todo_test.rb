# frozen_string_literal: true

require "test_helper"

class TodoTest < ActiveSupport::TestCase
  context "settings" do
    should "be able to create a todo with settings" do
      assert_predicate build(:todo, :with_settings), :valid?
    end
  end

  context "with custom fields" do
    setup do
      @todo = create(:todo)
      field = create(:field, source: @todo, name: "Quantity")
      item  = create(:item, todo: @todo, name: "Foo")
      create(:field_association, target: item, field:, value: "1")
    end

    context "#custom_fields" do
      should "return the custom fields" do
        assert_equal [:quantity], @todo.custom_fields
      end
    end

    context "#filterable_fields" do
      should "return the custom fields" do
        assert_equal %i[name_eq quantity_eq], @todo.filterable_fields
      end
    end
  end
end
