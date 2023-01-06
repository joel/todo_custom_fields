# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :todo, inverse_of: :items, optional: false
  broadcasts_to :todo
  validates :name, presence: true
end
