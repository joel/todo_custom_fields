# frozen_string_literal: true

require "test_helper"

class ItemTest < ActiveSupport::TestCase
  context "add fields" do
    setup do
      @todo = create(:todo, :with_fields)
      @item = create(:item, todo: @todo)
    end

    should "add fields" do
      assert_equal 5, @todo.fields.count

      position = 0
      @todo.fields.each do |field|
        @item.field_associations.create(field:, position: position += 1,
                                        value: "value - [#{field.name}] - #{rand(1000)}")
      end

      assert_equal @item.fields.count, @todo.fields.count
    end
  end
end
