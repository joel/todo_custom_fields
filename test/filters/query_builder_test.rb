# frozen_string_literal: true

require "test_helper"

class QueryBuilderTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      todo  = create(:todo)
      field = create(:field, source: todo, name: "Quantity")
      item  = create(:item, todo:, name: "Foo")

      create(:field_association, target: item, field:, value: "1")

      create(:item, todo:, name: "Bar")
      create(:item, todo: create(:todo), name: "Baz")

      @collection = Item.all
    end

    context "#query" do
      should "build the query with join table" do
        conditions = {
          name: "Foo",
          field_associations: { value: "1" }
        }

        sql = <<-SQL.squish
          SELECT
            "items"."id" AS t0_r0,
            "items"."name" AS t0_r1,
            "items"."todo_id" AS t0_r2,
            "items"."created_at" AS t0_r3,
            "items"."updated_at" AS t0_r4,
            "field_associations"."id" AS t1_r0,
            "field_associations"."field_id" AS t1_r1,
            "field_associations"."target_type" AS t1_r2,
            "field_associations"."target_id" AS t1_r3,
            "field_associations"."value" AS t1_r4,
            "field_associations"."position" AS t1_r5,
            "field_associations"."created_at" AS t1_r6,
            "field_associations"."updated_at" AS t1_r7
          FROM "items"
          LEFT OUTER JOIN "field_associations" ON "field_associations"."target_type" = 'Item'
            AND "field_associations"."target_id" = "items"."id"
          WHERE "items"."name" = 'Foo' AND "field_associations"."value" = '1'
        SQL

        assert_equal(
          sql,
          QueryBuilder.new(@collection).query(conditions).to_sql
        )
      end
    end
  end
end
