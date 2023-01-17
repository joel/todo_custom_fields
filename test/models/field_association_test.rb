# frozen_string_literal: true

require "test_helper"

class FieldAssociationTest < ActiveSupport::TestCase
  context "with a string field" do
    setup do
      @field_association = build(:field_association)
      @field_association.field = create(:field, field_type: "string")
    end

    should "be valid with a string value" do
      @field_association.value = "Test"

      assert @field_association.save
      assert_equal "Test", @field_association.value
    end

    should "not be valid with other type" do
      @field_association.value = 42

      assert_not @field_association.valid?
      assert_equal({ value: ["must be a string"] }, @field_association.errors.messages)
    end
  end

  context "with a date field" do
    setup do
      @field_association = build(:field_association)
      @field_association.field = create(:field, field_type: "date")
      travel_to Date.new(2004, 11, 24)
    end

    teardown do
      travel_back
    end

    should "be valid with a date value" do
      @field_association.value = 1.hour.ago

      assert @field_association.save
      assert_equal "2004-11-23 23:00:00 UTC", @field_association.value
    end

    should "not be valid with other type" do
      @field_association.value = 1.hour.ago.to_s

      assert_not @field_association.valid?
      assert_equal({ value: ["must be a date"] }, @field_association.errors.messages)
    end
  end
end
