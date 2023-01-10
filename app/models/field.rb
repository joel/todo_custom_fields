# frozen_string_literal: true

class Field < ApplicationRecord
  broadcasts_to :source

  validates :name, presence: true, length: { maximum: 255 }

  belongs_to :source, polymorphic: true, optional: true
end
