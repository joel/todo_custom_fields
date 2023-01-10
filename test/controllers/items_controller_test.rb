# frozen_string_literal: true

require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = create(:todo, :with_items)
    @item = @todo.items.take
  end

  test "should get new" do
    get new_todo_item_url(@todo)

    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count") do
      post todo_items_url(@todo), params: { item: { name: @item.name, todo_id: @item.todo_id } }
    end

    assert_redirected_to todo_item_url(@todo, Item.last)
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete todo_item_url(@todo, @item)
    end

    assert_redirected_to todo_items_url(@todo)
  end
end
