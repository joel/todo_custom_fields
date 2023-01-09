# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    name { FFaker::AnimalUS.common_name }

    trait :with_source do
      association :source, factory: :todo
    end
  end
end
