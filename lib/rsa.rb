class RSA
  include Math

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

  def encrypt(message, public_key)
    ciphed_message = message.bytes.map do |byte|
      cbyte = ((byte.to_i ** public_key.e) % public_key.n).to_s
      missing_chars = public_key.n.to_s.size - cbyte.size
      '0' * missing_chars + cbyte
    end.join

    @logger.success("Ciphed message: #{ciphed_message}")

    ciphed_message
  end

  def decrypt(ciphed_message, private_key)
    deciphed_message = ciphed_message.chars.each_slice(private_key.n.to_s.size).map do |arr|
      (arr.join.to_i ** private_key.d) % private_key.n
    end.pack('c*')

    @logger.success("Deciphed message: #{deciphed_message}")

    deciphed_message
  end
end
