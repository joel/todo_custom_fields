# frozen_string_literal: true

require "test_helper"

class ObfuscatorTest < ActiveSupport::TestCase
  setup do
    @obfuscator = Obfuscator.new
  end

  should "encrypt and decrytp message" do
    message = "Hello World"

    assert_equal message, @obfuscator.decrypt(@obfuscator.encrypt(message))
  end
end
