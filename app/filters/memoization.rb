# frozen_string_literal: true

class Memoization
  def initialize(object, attributes = {})
    @object = object

    proxy = Module.new

    object.filterable_fields.each do |predicate|
      proxy.define_method("#{predicate}=") do |value|
        instance_variable_set("@#{predicate}", value)
      end

      proxy.define_method(predicate) do
        instance_variable_get("@#{predicate}")
      end
    end

    extend proxy

    @fields = filterable_fields

    attributes.each do |key, value|
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

  private

  attr_reader :object
end
