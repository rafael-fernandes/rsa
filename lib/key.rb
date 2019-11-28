class Key
  attr_accessor :value, :type, :n, :e, :d

  def initialize(value, type)
    @value = value
    @type = type
    @logger = TTY::Logger.new { |config| config.level = $TTY_LEVEL }
  end

  def public?
    type == :public
  end

  def private?
    type == :private
  end

  def n
    @value[:n]
  end

  def e
    return nil if private?
    
    @value[:e]
  end

  def d
    return nil if public?

    @value[:d]
  end

  def to_s
    case type
    when :public
      "(n => #{n}, e => #{e})"
    when :private
      "(n => #{n}, d => #{d})"
    end
  end
end
