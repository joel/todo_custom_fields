# frozen_string_literal: true

require "test_helper"

class MemoizationTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      todo  = create(:todo)
      field = create(:field, source: todo, name: "Quantity")
      item  = create(:item, todo:, name: "Foo")

      create(:field_association, target: item, field:, value: "1")

      @memoization = Memoization.new(todo, name_eq: "bar")
    end

    should "create the getter" do
      assert_respond_to @memoization, :name_eq
      assert_respond_to @memoization, :quantity_eq
    end

    should "return it as params" do
      assert_equal(
        { name_eq: "bar", quantity_eq: nil },
        @memoization.to_params
      )
    end
  end
end
