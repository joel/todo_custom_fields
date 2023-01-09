# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    name { FFaker::AnimalUS.common_name }
  end
end
