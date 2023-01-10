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
        FieldAssociation.create(field: field, target: @item, value: "value #{field.name} - #{rand(100)}", position: position += 1)
      end

      assert_equal @item.fields.count, @todo.fields.count
    end

  end

end
