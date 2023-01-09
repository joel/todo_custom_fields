# frozen_string_literal: true

require "test_helper"

class FieldTest < ActiveSupport::TestCase
  context "validations" do
    setup do
      @field = Field.new
    end

    should "be valid" do
      @field.name = "Test"

      assert_predicate @field, :valid?
    end
  end
end
