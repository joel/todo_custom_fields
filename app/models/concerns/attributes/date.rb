# frozen_string_literal: true

module Attributes
  module Date
    extend ActiveSupport::Concern

    included do
      attribute :value, :datetime
    end
  end
end
