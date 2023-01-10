# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    name { FFaker::AnimalUS.common_name }

    trait :with_items do
      transient do
        items_count { 5 }
      end

      after(:create) do |todo, evaluator|
        create_list(:item, evaluator.items_count, todo:)
      end
    end

    trait :with_fields do
      transient do
        fields_count { 5 }
      end

      after(:create) do |todo, evaluator|
        create_list(:field, evaluator.fields_count, source: todo)
      end
    end
  end
end
