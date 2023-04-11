# frozen_string_literal: true

require "test_helper"

class QueryFragmentTest < ActiveSupport::TestCase
  context "with custom fields" do
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
        query_fragment.query,
        [
          "datetime(substr(field_associations.value, 1, 19)) > datetime(:datetime) AND fields.identifier = :identifier",
          {
            datetime: 3.days.ago.strftime("%Y-%m-%d %H:%M:%S"),
            identifier: "produced_date"
          }
        ]
      )
    end
  end
end
