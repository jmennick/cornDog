require 'rails_helper'

RSpec.describe AccountGroup, type: :model do
  it 'accepts the default fabricator' do
    group = Fabricate.build(:account_group)
    expect(group).to be_valid
  end

  context '#name' do
    it 'cannot be nil' do
      group = Fabricate.build(:account_group, name: nil)
      expect(group).not_to be_valid
    end

    it 'cannot be an empty string' do
      group = Fabricate.build(:account_group, name: '')
      expect(group).not_to be_valid
    end
  end

  context '#base_code' do
    it 'cannot be zero' do
      group = Fabricate.build(:account_group, base_code: 0)
      expect(group).not_to be_valid
    end

    it 'cannot be negative' do
      group = Fabricate.build(:account_group, base_code: -1)
      expect(group).not_to be_valid
    end

    it 'cannot be nil' do
      group = Fabricate.build(:account_group, base_code: nil)
      expect(group).not_to be_valid
    end

    it 'must end in zero' do
      group = Fabricate.build(:account_group, base_code: 101)
      expect(group).not_to be_valid
    end
  end

  context '#description'
end
