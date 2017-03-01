# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'fabrication'
# require 'faker'

User.create(name: 'John Doe', email: 'jdoe@corndog.herokuapp.com')

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
