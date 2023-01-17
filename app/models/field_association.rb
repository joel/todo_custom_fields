# frozen_string_literal: true

class FieldAssociation < ApplicationRecord
  belongs_to :field
  belongs_to :target, polymorphic: true

  def field=(field)
    super
    set_value_type
  end

  attribute :value, :string

  private

  def set_value_type
    return unless field_changed?

    mod = "::Attributes::#{field.field_type.capitalize}".constantize
    self.class.include(mod) unless self.class.included_modules.include?(mod)
  rescue NameError
    raise "Unknown field type: #{field.field_type}"
  end
end
