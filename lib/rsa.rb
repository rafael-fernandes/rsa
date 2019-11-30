class RSA
  include Math

  class DigitalSignature
    def initialize(message, private_key)
      @rsa = RSA.new
      @message = message
      @private_key = private_key

      @logger = TTY::Logger.new { |config| config.level = $TTY_LEVEL }
    end

    def authenticator_block
      Digest::SHA1.hexdigest(@message)
    end

    def digital_signature
      @rsa.encrypt(authenticator_block, @private_key)
    end

    def signature_pack
      { message: @message, signature: digital_signature }
    end

    def hex_signature(signature)
      signature.split(' ').map do |i|
        i.to_i.to_s(16).upcase
      end.join(' ')
    end

    def valid?(message, digital_signature, public_key)
      hash = Digest::SHA1.hexdigest(message)
      deciphed_signature = @rsa.decrypt(digital_signature, public_key)

      @logger.info("Mensagem: '#{message}'")
      @logger.success("Hash da mensagem: #{hash}")
      @logger.info("Assinatura digital: #{hex_signature(digital_signature)}")
      @logger.success("Assinatura digital decifrada: #{deciphed_signature}")

      if hash == deciphed_signature
        @logger.success("Os hashs são iguais")
      else
        @logger.error("Os hashs não são iguais")
      end
    end
  end

  def initialize
    @logger = TTY::Logger.new { |config| config.level = $TTY_LEVEL }
  end

  def generate_keys
    p, q = get_primes

    n = n(p, q)
    phi = phi(p, q)
    e = e(phi)
    d = d(e, phi)

    [{ e: e, n: n }, { d: d, n: n }]
  end

  def encrypt(message, key)
    key_part = key.public? ? key.e : key.d
    n = key.n

    ciphed_array = message.split('').map do |byte|
      byte.ord ** key_part % n
    end

    ciphed_array.join(' ')
  end

  def decrypt(ciphed_message, key)
    key_part = key.public? ? key.e : key.d
    n = key.n

    array = ciphed_message.split(' ').map do |byte|
      (byte.to_i ** key_part % n).chr("UTF-8")
    end

    array.join
  end
end
