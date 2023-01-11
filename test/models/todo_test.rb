# frozen_string_literal: true

require "test_helper"

class TodoTest < ActiveSupport::TestCase
  context "settings" do
    should "be able to create a todo with settings" do
      assert_predicate build(:todo, :with_settings), :valid?
    end
  end
end
