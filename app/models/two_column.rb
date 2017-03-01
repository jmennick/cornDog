class TwoColumn
  attr_reader :debit, :credit

  def initialize(debit, credit)
    @debit, @credit = debit, credit
  end

  def self.value(val, side: :left)
    case side
    when :left
      return TwoColumn.new(val, 0.0)
    when :right
      return TwoColumn.new(0.0, val)
    else
      raise ArgumentError, "invalid side \"#{side}\""
    end
  end

  def ==(other)
    debit == other.debit && credit == other.credit
  end

  def abs_credit
    credit - debit
  end

  def abs_debit
    debit - credit
  end

  def +(other)
    _d = debit + other.debit
    _c = credit + other.credit
    TwoColumn.new(_d, _c)
  end

  def -(other)
    _d = debit - other.debit
    _c = credit - other.credit
    TwoColumn.new(_d, _c)
  end

  def to_s
    "[d: #{debit} | c: #{credit}]"
  end

  def inspect
    to_s
  end
end
