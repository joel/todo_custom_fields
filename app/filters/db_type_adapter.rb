# frozen_string_literal: true

class DbTypeAdapter
  def initialize(field_type, value)
    @field_type = field_type
    @value = value
  end

  delegate :db_placeholder, to: :db_type_adapter

  delegate :target_placeholder, to: :db_type_adapter

  private

  attr_reader :field_type, :value

  def db_type_adapter
    "DbTypeAdapters::DbTypeAdapter#{database_adapter.classify}".constantize.new(field_type, value)
  end

  def database_adapter
    ActiveRecord::Base.connection.adapter_name.downcase
  end
end
