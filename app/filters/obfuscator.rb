# frozen_string_literal: true

require "openssl"

class Obfuscator
  def encrypt(plain_data)
    cipher = OpenSSL::Cipher.new("aes-128-cbc")
    cipher.encrypt
    cipher.key = Rails.configuration.x.obfuscator.secret_key

    Base64.encode64(cipher.update(plain_data) + cipher.final)
  end

  def decrypt(encrypted_data)
    decipher = OpenSSL::Cipher.new("aes-128-cbc")
    decipher.decrypt
    decipher.key = Rails.configuration.x.obfuscator.secret_key

    decipher.update(Base64.decode64(encrypted_data)) + decipher.final
  end

  private

  attr_accessor :key, :iv
end
