# frozen_string_literal: true

require "test_helper"

class MemoizationTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      todo  = create(:todo)
      field = create(:field, source: todo, name: "Quantity")
      item  = create(:item, todo:, name: "Foo")

      create(:field_association, target: item, field:, value: "1")

      @memoization = Memoization.new(todo, name: { "name" => "bar" }.to_json)
    end

    should "create the getter" do
      assert_respond_to @memoization, :name
      assert_respond_to @memoization, :quantity
    end

    should "return it as params" do
      assert_equal(
        { name: { "name" => "bar" }.to_json, quantity: nil },
        @memoization.to_params
      )
    end

    context "#constraints" do
      should "return the constraints" do
        assert_equal(
          [{ "name" => "bar" }],
          @memoization.constraints
        )
      end
    end
  end
end
