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
      should "build the query with join table" do
        constraints = [
          { name: "Grocery List" },
          {field_associations: { value: "1", fields: { identifier: "quantity" } }},
          {field_associations: { value: "1 Litre", fields: { identifier: "format" } }}
        ]

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
            "field_associations"."updated_at" AS t1_r7,
            "fields"."id" AS t2_r0,
            "fields"."name" AS t2_r1,
            "fields"."identifier" AS t2_r2,
            "fields"."metadata" AS t2_r3,
            "fields"."policy" AS t2_r4,
            "fields"."position" AS t2_r5,
            "fields"."source_type" AS t2_r6,
            "fields"."source_id" AS t2_r7,
            "fields"."field_type" AS t2_r8,
            "fields"."created_at" AS t2_r9,
            "fields"."updated_at" AS t2_r10
          FROM "items"
          LEFT OUTER JOIN "field_associations" ON "field_associations"."target_type" = 'Item'
            AND "field_associations"."target_id" = "items"."id"
          LEFT OUTER JOIN "fields" ON "fields"."id" = "field_associations"."field_id"
          WHERE ("items"."name" = 'Grocery List'
            OR "field_associations"."value" = '1'
            AND "fields"."identifier" = 'quantity'
            OR "field_associations"."value" = '1 Litre'
            AND "fields"."identifier" = 'format')
        SQL

        assert_equal(
          sql,
          QueryBuilder.new(@collection).query(constraints).to_sql
        )
      end

      # should "build the query without join table" do
      #   conditions = {
      #     name: "Foo"
      #   }

      #   sql = <<-SQL.squish
      #     SELECT "items".* FROM "items" WHERE "items"."name" = 'Foo'
      #   SQL

      #   assert_equal(
      #     sql,
      #     QueryBuilder.new(@collection).query(conditions).to_sql
      #   )
      # end
    end
  end
end
