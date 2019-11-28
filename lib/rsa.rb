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

  def n(p, q)
    n = p * q
  end

  def phi(p, q)
    (p - 1) * (q - 1)
  end

  def e(phi)
    phi.downto(2).find do |i|     
      Prime.prime?(i) and phi % i != 0
    end
  end

  def d(e, phi)
    inverse_modulo(e, phi)
  end

  def encrypt(message, e, n)
    message.bytes.map do |byte|
      cbyte = ((byte.to_i ** e) % n).to_s
      missing_chars = n.to_s.size - cbyte.size
      '0' * missing_chars + cbyte
    end.join
  end

  def decrypt(ciphed_message, d, n)
    ciphed_message.chars.each_slice(n.to_s.size).map do |arr|
      (arr.join.to_i ** d) % n
    end.pack('c*')
  end
end
