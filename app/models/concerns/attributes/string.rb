# frozen_string_literal: true

module Attributes
  module String
    extend ActiveSupport::Concern

    included do
      attribute :value, :string
    end
  end
end
