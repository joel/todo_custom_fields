# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    name { FFaker::Color.name }

    trait :with_source do
      association :source, factory: :todo
    end

    factory :integer_field do
      field_type { "integer" }
    end

    factory :date_field do
      field_type { "integer" }
    end

    factory :boolean_field do
      field_type { "integer" }
    end
  end
end
