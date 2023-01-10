# frozen_string_literal: true

require "test_helper"

class FieldTest < ActiveSupport::TestCase
  context "validations" do
    setup do
      @field = Field.new
    end

    should "not be valid" do
      assert_not_predicate @field, :valid?
    end

    context "with name" do
      setup { @field.name = "Test" }

      should "be valid" do
        assert_predicate @field, :valid?
      end

      should "set an identifier" do
        assert_predicate @field, :valid?
        assert_equal "test", @field.identifier
      end
    end
  end
end
