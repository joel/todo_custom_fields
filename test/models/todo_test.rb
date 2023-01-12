# frozen_string_literal: true

require "test_helper"

class TodoTest < ActiveSupport::TestCase
  context "settings" do
    should "be able to create a todo with settings" do
      assert_predicate build(:todo, :with_settings), :valid?
    end
  end

  context "#custom_fields" do
    setup do
      @todo = create(:todo, :with_field_associations)
    end

    should "return the custom fields" do
      assert_equal @todo.fields.pluck(:identifier).map(&:to_sym), @todo.custom_fields
    end
  end
end
