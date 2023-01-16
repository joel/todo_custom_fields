# frozen_string_literal: true

require "openssl"

class Obfuscator
  def initialize(key = nil, iv = nil)
    @key = key
    @iv  = iv
  end

  def encrypt(plain_data)
    cipher = OpenSSL::Cipher.new("aes-128-cbc")
    cipher.encrypt
    self.key = cipher.random_key
    self.iv  = cipher.random_iv

    cipher.update(plain_data) + cipher.final
  end

  def decrypt(encrypted_data)
    decipher = OpenSSL::Cipher.new("aes-128-cbc")
    decipher.decrypt
    decipher.key = key
    decipher.iv = iv

    decipher.update(encrypted_data) + decipher.final
  end

  private

  attr_accessor :key, :iv
end
