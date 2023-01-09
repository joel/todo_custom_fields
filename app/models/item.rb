# frozen_string_literal: true

class Item < ApplicationRecord
  broadcasts_to :todo

  belongs_to :todo, inverse_of: :items, optional: false

  validates :name, presence: true
end
