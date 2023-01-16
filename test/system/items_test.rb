# frozen_string_literal: true

require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @todo = create(:todo, :with_items)
    @item = @todo.items.take
  end

  test "should create item" do
    visit todo_url(@todo)

    page.assert_selector("div.item", count: 5)

    fill_in "item_name", with: FFaker::Color.name

    click_on "Create Item"

    page.assert_selector("div.item", count: 6)

    click_on "Back"
  end

  test "should destroy Item" do
    visit todo_url(@todo)

    page.assert_selector("div.item", count: 5)

    accept_alert do
      click_on "Destroy this item", match: :first
    end

    page.assert_selector("div.item", count: 4)

    assert_text "Item was successfully destroyed"
  end
end
