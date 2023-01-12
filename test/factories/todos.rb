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

    trait :with_settings do
      transient do
        settings_count { 5 }
      end

      after(:create) do |todo, evaluator|
        create_list(:setting, evaluator.settings_count, todo:)
      end
    end

    trait :with_field_associations do
      with_fields

      after(:create) do |todo, _evaluator|
        todo.fields.each do |field|
          create(:field_association, target: todo, field:)
        end
      end
    end
  end
end
