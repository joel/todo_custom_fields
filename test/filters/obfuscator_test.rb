# frozen_string_literal: true

require "test_helper"

class ObfuscatorTest < ActiveSupport::TestCase
  should "encrypt and decrytp message" do
    message = "Hello World"

    5.times.each do
      assert_equal message, Obfuscator.new.decrypt(Obfuscator.new.encrypt(message))
    end
  end
end
