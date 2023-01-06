require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @todo = todos(:one)
    @item = @todo.items.take
  end

  test "should create item" do
    visit todo_url(@todo)

    page.assert_selector('div.item', :count => 1)

    fill_in "item[name]", with: @item.name

    click_on "Create Item"

    page.assert_selector('div.item', :count => 2)

    click_on "Back"
  end


  test "should destroy Item" do
    visit todo_url(@todo)

    page.assert_selector('div.item', :count => 1)

    accept_alert do
    click_on "Destroy this item", match: :first
    end

    page.assert_selector('div.item', :count => 0)

    assert_text "Item was successfully destroyed"
  end
end
