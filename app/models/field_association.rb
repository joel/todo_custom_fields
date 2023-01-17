# frozen_string_literal: true

class FieldAssociation < ApplicationRecord
  belongs_to :field
  belongs_to :target, polymorphic: true

  validates :value, presence: true
  validate :value_type

  private

  def value_type
    return if field.nil?
    return if value.nil?

    case field.field_type
    when "integer"
      return if raw_value.is_a?(Integer)

      errors.add(:value, "must be an integer")
    when "string"
      return if raw_value.is_a?(String)

      errors.add(:value, "must be a string")
    when "boolean"
      return if raw_value.is_a?(TrueClass) || raw_value.is_a?(FalseClass)

      errors.add(:value, "must be a boolean")
    when "date"
      return if raw_value.is_a?(DateTime) || raw_value.is_a?(Date) || raw_value.is_a?(ActiveSupport::TimeWithZone)

      errors.add(:value, "must be a date")
    else
      raise "Unknown field type: #{field.field_type}"
    end
  end

  def raw_value
    read_attribute_before_type_cast(:value)
  end
end
