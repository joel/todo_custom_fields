# frozen_string_literal: true

# Custom field model.
class Field < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  belongs_to :target, polymorphic: true, optional: true
  belongs_to :source, polymorphic: true, optional: true

  scope :for_resource, ->(target) { where(target:) }
  scope :root, -> { where(source: nil) }

  class << self
    def for_todo(todo)
      for_resource(todo)
    end
  end
end
