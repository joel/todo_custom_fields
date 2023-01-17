# frozen_string_literal: true

module Attributes
  module Integer
    extend ActiveSupport::Concern

    included do
      attribute :value, :integer
    end
  end
end
