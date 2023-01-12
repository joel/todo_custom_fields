# frozen_string_literal: true

require "test_helper"

class FilteringTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      todo  = create(:todo)
      field = create(:field, source: todo, name: "Quantity")
      item  = create(:item, todo:, name: "Foo")

      create(:field_association, target: item, field:, value: "1")

      @controller = Class.new do
        include Filtering
      end.new

      create(:item, todo:, name: "Bar")
      create(:item, todo: create(:todo), name: "Baz")

      @collection = Item.all
    end

    context "when filtering asked" do
      context "#filter" do
        should "return the filtered records" do
          assert_equal(
            ["Foo"],
            @controller.filter(@collection, { name_eq: "Foo" }).result.order(:name).pluck(:name)
          )
        end
      end
    end

    context "when filtering not asked" do
      context "#filter" do
        should "return the unfiltered records" do
          assert_equal(
            %w[Bar Baz Foo],
            @controller.filter(@collection, {}).result.order(:name).pluck(:name)
          )
        end
      end
    end
  end
end
