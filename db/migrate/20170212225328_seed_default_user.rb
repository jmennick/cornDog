class SeedDefaultUser < ActiveRecord::Migration[5.0]
  def change
    User.create! name: 'John Doe', email: 'jdoe@corndog.herokuapp.com'
  end
end
