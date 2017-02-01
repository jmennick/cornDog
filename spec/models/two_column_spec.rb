RSpec.describe TwoColumn do
  context '#==' do
    it 'returns true when credit and debit are same' do
      debit_value = 69_000.00.to_d
      credit_value = 42_000.00.to_d
      lhs = TwoColumn.new(debit_value, credit_value)
      rhs = TwoColumn.new(debit_value, credit_value)
      expect(lhs).to eq(rhs)
    end

    it 'returns false when credit is different' do
      debit_value = 42_000.00.to_d
      lhs_credit = 69_000.00.to_d
      rhs_credit = 70_000.00.to_d
      lhs = TwoColumn.new(debit_value, lhs_credit)
      rhs = TwoColumn.new(debit_value, rhs_credit)
      expect(lhs).not_to eq(rhs)
    end

    it 'returns false when debit is different' do
      lhs_debit = 69_000.to_d
      rhs_debit = 70_000.to_d
      credit_value = 42_000.00.to_d
      lhs = TwoColumn.new(lhs_debit, credit_value)
      rhs = TwoColumn.new(rhs_debit, credit_value)
      expect(lhs).not_to eq(rhs)
    end
  end

  context '#abs_credit' do
    it 'returns the difference of credit from the debit' do
      debit_value = 69_000.00.to_d
      credit_value = 42_000.00.to_d
      val = TwoColumn.new(debit_value, credit_value)
      expect(val.abs_credit).to eq(credit_value - debit_value)
    end
  end

  context '#abs_debit' do
    it 'returns the difference of debit from the credit' do
      debit_value = 69_000.00.to_d
      credit_value = 42_000.00.to_d
      val = TwoColumn.new(debit_value, credit_value)
      expect(val.abs_debit).to eq(debit_value - credit_value)
    end
  end

  context '#+' do
    it 'returns the correct value' do
      lhs_debit = 10_000.00.to_d; lhs_credit = 42_000.00.to_d
      lhs = TwoColumn.new(lhs_debit, lhs_credit)

      rhs_debit = 50_000.00.to_d; rhs_credit = 15_000.00.to_d
      rhs = TwoColumn.new(rhs_debit, rhs_credit)

      result_val = lhs + rhs
      expect(result_val.debit).to eq(lhs_debit + rhs_debit)
      expect(result_val.credit).to eq(lhs_credit + rhs_credit)
    end
  end

  context '#-' do
    it 'returns the correct value' do
      lhs_debit = 10_000.00.to_d; lhs_credit = 42_000.00.to_d
      lhs = TwoColumn.new(lhs_debit, lhs_credit)

      rhs_debit = 50_000.00.to_d; rhs_credit = 15_000.00.to_d
      rhs = TwoColumn.new(rhs_debit, rhs_credit)

      result_val = lhs - rhs
      expect(result_val.debit).to eq(lhs_debit - rhs_debit)
      expect(result_val.credit).to eq(lhs_credit - rhs_credit)
    end
  end
end
