# frozen_string_literal: true

require "test_helper"

class FieldAssociationTest < ActiveSupport::TestCase
  # context "with a string field" do
  #   should "have a string value" do
  #     field_association = create(:field_association, field: create(:field, field_type: "string"))
  #     field_association.value = "Test"

  #     assert_equal "Test", field_association.value
  #     assert field_association.save
  #     assert field_association.value.is_a?(String)
  #   end
  # end

  context "with a integer field" do
    should "have a integer value" do
      field_association = build(:field_association, value: "1")
      assert_equal(
        "ActiveModel::Type::String",
        field_association.class.attributes_to_define_after_schema_loads["value"][0].class.name
      )
      field_association.field = create(:field, field_type: "date")
      assert_equal(
        "ActiveRecord::Type::DateTime",
        field_association.class.attributes_to_define_after_schema_loads["value"][0].class.name
      )
      field_association.field = create(:field, field_type: "integer")
      assert_equal(
        "ActiveRecord::ConnectionAdapters::SQLite3Adapter::SQLite3Integer",
        field_association.class.attributes_to_define_after_schema_loads["value"][0].class.name
      )
      field_association.save!

      assert_equal "1", field_association.value
      assert_equal 1, field_association.reload.value
      assert field_association.value.is_a?(Integer)
    end
  end
end
