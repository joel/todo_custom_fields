# frozen_string_literal: true

require "test_helper"

class QueryFragmentTest < ActiveSupport::TestCase
  context "with custom fields" do
    setup do
      travel_to Time.zone.local(2004, 11, 24, 1, 4, 44)
    end

    teardown do
      travel_back
    end

    should "find the fresh Wine item" do
      query_fragment = QueryFragment.new(
        {
          identifier: "produced_date",
          value: 3.days.ago,
          field_type: "datetime",
          query: ":db_placeholder > :target_placeholder AND fields.identifier = :identifier"
        }
      )

      assert_equal(
        [
          "datetime(substr(field_associations.value, 1, 19)) > datetime('2004-11-21 01:04:44') AND fields.identifier = :identifier",
          {
            identifier: "produced_date"
          }
        ], query_fragment.query
      )
    end
  end
end
