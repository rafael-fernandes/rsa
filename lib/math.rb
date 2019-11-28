require 'prime'

module Math
  def get_primes
    Prime.first(100).sample(2)
  end

  def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
      x, last_x, y, last_y = 0, 1, 1, 0
      while remainder != 0
        last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
        x, last_x = last_x - quotient*x, x
        y, last_y = last_y - quotient*y, y
      end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end

  def inverse_modulo(e, et)
    g, x = extended_gcd(e, et)
    raise 'The maths are broken!' if g != 1
    x % et
  end
end
