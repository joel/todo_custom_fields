# frozen_string_literal: true

class Todo < ApplicationRecord
  has_many :items, inverse_of: :todo, dependent: :destroy

  has_many :fields, as: :source, inverse_of: :source, dependent: :destroy

  validates :name, presence: true
end
