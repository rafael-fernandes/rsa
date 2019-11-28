class Key
  attr_accessor :value, :type, :n, :e, :d

  def initialize(value, type)
    @value = value
    @type = type
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
end
