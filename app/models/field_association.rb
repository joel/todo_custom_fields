# frozen_string_literal: true

class FieldAssociation < ApplicationRecord
  belongs_to :field
  belongs_to :target, polymorphic: true
end
