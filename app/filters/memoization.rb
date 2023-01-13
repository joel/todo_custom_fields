# frozen_string_literal: true

class Memoization
  def initialize(object, filter_params = {})
    @object = object
    @filter_params = filter_params.to_h.symbolize_keys

    proxy = Module.new

    # Create the getters and setters for the custom fields
    object.filterable_fields.each do |predicate|
      proxy.define_method("#{predicate}=") do |value|
        instance_variable_set("@#{predicate}", value)
      end

      proxy.define_method(predicate) do
        instance_variable_get("@#{predicate}")
      end
    end

    extend proxy

    # Cache filterable_fields
    @fields = filterable_fields

    # Set the values
    filter_params.each do |key, value|
      next unless @fields.include?(key.to_sym)

      public_send("#{key}=", value) # rubocop:disable GitlabSecurity/PublicSend
    end
  end

  delegate :filterable_fields, to: :object

  def to_params
    {}.tap do |predicates|
      filterable_fields.each do |key|
        predicates[key] = public_send(key) # rubocop:disable GitlabSecurity/PublicSend
      end
    end
  end

  def constraints
    filter_params.values.select(&:present?).map do |constraints|
      JSON.parse(constraints)
    end
  end

  private

  attr_reader :object, :filter_params
end
