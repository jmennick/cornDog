require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'accepts the default fabricator' do
    account = Fabricate.build(:account)
    expect(account).to be_valid
  end

  context '#name' do
    it 'cannot be an empty string' do
      account = Fabricate.build(:account, name: '')
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, name: nil)
      expect(account).not_to be_valid
    end

    it 'cannot be only whitespace' do
      account = Fabricate.build(:account, name: ' ')
      expect(account).not_to be_valid
    end
  end

  context '#code' do
    it 'cannot be zero' do
      account = Fabricate.build(:account, code: 0)
      expect(account).not_to be_valid
    end

    it 'cannot be negative' do
      account = Fabricate.build(:account, code: -1)
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, code: nil)
      expect(account).not_to be_valid
    end
  end

  context '#order' do
    it 'cannot be zero' do
      account = Fabricate.build(:account, order: 0)
      expect(account).not_to be_valid
    end

    it 'cannot be negative' do
      account = Fabricate.build(:account, order: -1)
      expect(account).not_to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, order: nil)
      expect(account).not_to be_valid
    end
  end

  context '#active' do
    it 'cannot be nil' do
      account = Fabricate.build(:account, active: nil)
      expect(account).not_to be_valid
    end

    it 'can be true' do
      account = Fabricate.build(:account, active: true)
      expect(account).to be_valid
    end

    it 'can be false' do
      account = Fabricate.build(:account, active: false)
      expect(account).to be_valid
    end
  end

  context '#description' do
    it 'can be nil' do
      account = Fabricate.build(:account, description: nil)
      expect(account).to be_valid
    end

    it 'can be 255 characters long' do
      account = Fabricate.build(:account, description: ?! * 255)
      expect(account).to be_valid
    end

    it 'cannot be more than 255 characters long' do
      account = Fabricate.build(:account, description: ?! * 256)
      expect(account).not_to be_valid
    end
  end

  context '#initial_balance' do
    it 'can be a negative number' do
      account = Fabricate.build(:account, initial_balance: -0.01)
      expect(account).to be_valid
    end

    it 'can be zero' do
      account = Fabricate.build(:account, initial_balance: 0.0)
      expect(account).to be_valid
    end

    it 'can be a positive number' do
      account = Fabricate.build(:account, initial_balance: 42.00)
      expect(account).to be_valid
    end

    it 'cannot be nil' do
      account = Fabricate.build(:account, initial_balance: nil)
      expect(account).not_to be_valid
    end
  end

  context '#normal_side_physical' do
    {
      current_asset: :left,
      long_term_asset: :left,
      current_liability: :right,
      long_term_liability: :right,
      revenue: :left,
      equity: :right,
      expense: :right
    }.each do |k,v|
      it "generates the correct value (#{v}) for an Account of kind \"#{k}\"" do
        account = Fabricate.build(:account, kind: k)
        expect(account.normal_side_physical).to eq(v)
      end
    end
  end
end
