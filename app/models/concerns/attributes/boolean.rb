# frozen_string_literal: true

module Attributes
  module Boolean
    extend ActiveSupport::Concern

    included do
      attribute :value, :boolean
    end
  end
end
