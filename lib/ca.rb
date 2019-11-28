class CA
  def initialize
    @rsa = RSA.new
  end

  def generate_keys
    KeyPair.new(*@rsa.generate_keys)
  end
end
