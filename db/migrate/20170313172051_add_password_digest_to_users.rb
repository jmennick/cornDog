class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_digest, :string, null: false, default: ''
    User.all.each{|u| u.update! password: '12345'}
  end
end
