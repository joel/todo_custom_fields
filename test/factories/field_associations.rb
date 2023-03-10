# frozen_string_literal: true

FactoryBot.define do
  factory :field_association do
    association :field
    association :target, factory: :item_with_todo

    value { FFaker::Color.name }
  end
end
