# frozen_string_literal: true

class Item < ApplicationRecord
  broadcasts_to :todo

  belongs_to :todo, inverse_of: :items, optional: false

  has_many :field_associations, as: :target, inverse_of: :target, dependent: :destroy
  has_many :fields, through: :field_associations, source: :field

  validates :name, presence: true

  accepts_nested_attributes_for :field_associations, allow_destroy: true, reject_if: :reject_field_associations

  def reject_field_associations(_attributes)
    false
  end
end
