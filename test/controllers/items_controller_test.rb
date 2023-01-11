# frozen_string_literal: true

require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = create(:todo, :with_items, :with_fields)
    @item = @todo.items.take
  end

  test "should get new" do
    get new_todo_item_url(@todo)

    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count") do
      post(
        todo_items_url(@todo),
        params: {
          item: {
            name: @item.name
          },
          fields: {
            @todo.fields.map(&:identifier).first => "foo"
          }
        }
      )
    end

    assert_redirected_to todo_item_url(@todo, Item.last)
    assert_predicate Item.last.field_associations, :present?
    assert_equal 1, Item.last.field_associations.count
    assert_equal "foo", Item.last.field_associations.first.value
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete todo_item_url(@todo, @item)
    end

    assert_redirected_to todo_items_url(@todo)
  end
end
