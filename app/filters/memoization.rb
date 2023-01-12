# frozen_string_literal: true

class Memoization
  ACCESSORS = %i[name_cont].freeze

  def initialize(attributes = {})
    attributes.each do |key, value|
      next unless ACCESSORS.include?(key.to_sym)

      public_send("#{key}=", value) # rubocop:disable GitlabSecurity/PublicSend
    end
  end

  ACCESSORS.each do |accessor|
    define_method("#{accessor}=") do |value|
      instance_variable_set("@#{accessor}", value)
    end

    define_method(accessor) do
      instance_variable_get("@#{accessor}")
    end
  end

  def to_params
    {}.tap do |predicates|
      ACCESSORS.each do |key|
        predicates[key] = public_send(key) # rubocop:disable GitlabSecurity/PublicSend
      end
    end
  end
end
