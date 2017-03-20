# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'fabrication'
# require 'faker'

User.find_or_create_by!(name: 'John Doe') do |u|
  u.name = 'John Doe'
  u.email = 'jdoe@corndog.herokuapp.com'
  u.role = 'no_access'
  u.password = '12345'
end

User.find_or_create_by!(name: 'Joe Admin') do |u|
  u.email = 'admin@corndog.com'
  u.role = 'admin'
  u.password = '12345'
end

User.find_or_create_by!(name: 'Joe Manager') do |u|
  u.email = 'manager@corndog.com'
  u.role = 'manager'
  u.password = '12345'
end

User.find_or_create_by!(name: 'Joe Accountant') do |u|
  u.email = 'accountant@corndog.com'
  u.role = 'accountant'
  u.password = '12345'
end

# acc1 = Account.first
# acc2 = Account.second
#
# 10.times do
#   je = Fabricate.build :journal_entry, items: [
#     Fabricate.build(:journal_entry_item, account: acc1),
#     Fabricate.build(:journal_entry_item, account: acc2)
#   ]
#   je.save!
# end
