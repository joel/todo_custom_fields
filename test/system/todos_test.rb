# frozen_string_literal: true

require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo = create(:todo)
  end

  test "visiting the index" do
    visit todos_url

    assert_selector "h1", text: "Todos"
  end

  test "should create todo" do
    visit todos_url
    click_on "New todo"

    fill_in "Todo", with: @todo.name
    fill_in "Setting", with: "A Setting"
    click_on "Create Todo"

    assert_text "Todo was successfully created"

    click_on "Back"
  end

  test "should create custom fields" do
    visit todo_url(@todo)

    fill_in "Custom Field Name", with: @todo.name
    click_on "Create Field"

    assert_text "Field was successfully created"

    click_on "Back"
  end

  test "should update Todo" do
    visit todo_url(@todo)
    click_on "Edit this todo", match: :first

    fill_in "Todo", with: @todo.name
    click_on "Update Todo"

    assert_text "Todo was successfully updated"
    click_on "Back"
  end

  test "should destroy Todo" do
    visit todo_url(@todo)
    click_on "Destroy this todo", match: :first

    assert_text "Todo was successfully destroyed"
  end

  context "with items" do
    setup do
      @todo = create(:todo, :with_items)
    end

    should "should filter items" do
      visit todo_url(@todo)

      page.assert_selector("div.item", count: 5)

      click_on "Save Filter"

      page.assert_selector("div.item", count: 1)

      click_on "Back"
    end
  end
end
