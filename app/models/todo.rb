# frozen_string_literal: true

class Todo < ApplicationRecord
  has_many :items, inverse_of: :todo, dependent: :destroy

  has_many :fields, as: :source, inverse_of: :source, dependent: :destroy
  has_many :settings, inverse_of: :todo, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :settings, allow_destroy: true, reject_if: :reject_settings

  def reject_settings(_attributes)
    false
  end

  # def settings_attributes=(attributes)
  #   super
  # end

  def custom_fields
    fields.pluck(:identifier).map(&:to_sym)
  end

  def filterable_fields
    [:name_eq, *fields.map(&:predicate).map(&:to_sym)]
  end
end
