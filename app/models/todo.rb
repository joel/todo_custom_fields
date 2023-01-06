class Todo < ApplicationRecord
  has_many :items, inverse_of: :todo, dependent: :destroy

  validates :name, presence: true
end
