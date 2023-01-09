# frozen_string_literal: true

require "test_helper"

class FieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @field = create(:field, :with_source)
    @todo = @field.source
  end

  test "should get new" do
    get new_todo_field_url(@todo)

    assert_response :success
  end

  test "should create item" do
    assert_difference("Field.count") do
      post todo_fields_url(@todo), params: { field: { name: FFaker::AnimalUS.common_name } }
    end

    assert_redirected_to todo_url(@todo)
  end
end
