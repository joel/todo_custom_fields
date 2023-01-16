# frozen_string_literal: true

require "test_helper"

class CollectionsTest < ActiveSupport::TestCase
  setup { @obfuscator = Obfuscator.new }

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
          ["1",
           "6UBX/7nxkHUvNeim0lQjA35ghiLIgXzeR/PBiBg10zFO2mIqL496W6Qs4fwY\n/hwVHgkN9YamDAL4eqMAR7TPazych/f+WIGb9Xq7JH3gGPI=\n"]
        ],
        collections.quantities
      )

      assert_equal(
        "{\"field_associations\":{\"value\":\"1\",\"fields\":{\"identifier\":\"quantity\"}}}",
        @obfuscator.decrypt(collections.quantities[1][1])
      )

      assert_equal [:quantity], collections.custom_fields
    end
  end
end
