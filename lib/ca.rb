class CA
  def initialize
    @rsa = RSA.new
  end

  def generate_keys
    public_key, private_key = @rsa.generate_keys

    public_key = Key.new(public_key, :public)
    private_key = Key.new(private_key, :private)

    [public_key, private_key]
  end
end
