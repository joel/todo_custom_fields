# frozen_string_literal: true

require "test_helper"

class QueryBuilderTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      todo           = create(:todo, name: "Grocery List")
      field_quantity = create(:field, source: todo, name: "Quantity")
      field_format   = create(:field, source: todo, name: "Format")

      item = create(:item, todo:, name: "Milk")
      create(:field_association, target: item, field: field_quantity, value: "1")
      create(:field_association, target: item, field: field_format, value: "1 Litre")

      item = create(:item, todo:, name: "Wine")
      create(:field_association, target: item, field: field_quantity, value: "1")
      create(:field_association, target: item, field: field_format, value: "0.75 Litre")

      create(:item, todo:, name: "Bar")
      create(:item, todo: create(:todo), name: "Baz")

      @collection = Item.all
    end

    context "#query" do
      should "find the milk item" do
        constraints = [
          { field_associations: { value: "1", fields: { identifier: "quantity" } } },
          { field_associations: { value: "1 Litre", fields: { identifier: "format" } } }
        ]

        assert_equal(
          ["Milk"],
          QueryBuilder.new(@collection).query(constraints).pluck(:name)
        )
      end

      should "find the wine item" do
        constraints = [
          { field_associations: { value: "1", fields: { identifier: "quantity" } } },
          { field_associations: { value: "0.75 Litre", fields: { identifier: "format" } } }
        ]

        assert_equal(
          ["Wine"],
          QueryBuilder.new(@collection).query(constraints).pluck(:name)
        )
      end

      should "find the wine and milk items" do
        constraints = [
          { field_associations: { value: "1", fields: { identifier: "quantity" } } }
        ]

        assert_equal(
          %w[Milk Wine],
          QueryBuilder.new(@collection).query(constraints).pluck(:name)
        )
      end

      should "find the bar item" do
        constraints = [
          { name: "Bar" }
        ]

        assert_equal(
          ["Bar"],
          QueryBuilder.new(@collection).query(constraints).pluck(:name)
        )
      end

      should "find no item" do
        constraints = [
          { name: "Bar" },
          { field_associations: { value: "1", fields: { identifier: "quantity" } } },
          { field_associations: { value: "0.75 Litre", fields: { identifier: "format" } } }
        ]

        assert_empty(
          QueryBuilder.new(@collection).query(constraints).pluck(:name)
        )
      end
    end
  end
end
