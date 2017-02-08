require 'rails_helper'

RSpec.describe User, type: :model do
  it 'accepts the default fabricator' do
    user = Fabricate.build(:user)
    expect(user).to be_valid
  end

  context '#name' do
    it 'cannot be an empty string' do
      user = Fabricate.build(:user, name: '')
      expect(user).not_to be_valid
    end
  end

  context '#email' do
    it 'cannot be a username-style input' do
      user = Fabricate.build(:user, email: 'gav5')
      expect(user).not_to be_valid
    end

    it 'cannot be an input with an invalid domain' do
      user = Fabricate.build(:user, email: 'gav5@corndog')
      expect(user).not_to be_valid
    end
  end
end
