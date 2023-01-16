# frozen_string_literal: true

require "test_helper"

class CollectionsTest < ActiveSupport::TestCase
  context "dynamic methods" do
    setup do
      @todo = create(:todo)
    end

    should "have the field methods" do
      field = create(:field, source: @todo, name: "Quantity")
      item  = create(:item, todo: @todo, name: "Foo")

      create(:field_association, target: item, field:, value: "1")

      collections = Collections.new(@todo)

      assert_respond_to collections, :names
      assert_respond_to collections, :quantities

      assert_equal(
        [
          ["Select…", nil],
          ["1", "{\"field_associations\":{\"value\":\"1\",\"fields\":{\"identifier\":\"quantity\"}}}"]

        ],
        collections.quantities
      )

      assert_equal [:quantity], collections.custom_fields
    end
  end
end
