# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { FFaker::AnimalUS.common_name }

    factory :item_with_todo do
      association :todo, factory: :todo
    end
  end
end
