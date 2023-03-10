# frozen_string_literal: true

FactoryBot.define do
  factory :setting do
    name { FFaker::AnimalUS.common_name }

    trait :with_todo do
      association :todo, factory: :todo
    end
  end
end
