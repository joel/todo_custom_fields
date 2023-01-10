# frozen_string_literal: true

class Field < ApplicationRecord
  broadcasts_to :source

  validates :name, presence: true, length: { maximum: 255 }, format: { with: /\A[a-zA-Z_]+\z/ }

  belongs_to :source, polymorphic: true, optional: true

  after_validation :set_identifier

  private

  def set_identifier
    return if errors.any?

    self.identifier = name.parameterize.underscore
  end
end
