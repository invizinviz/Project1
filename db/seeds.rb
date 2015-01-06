# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Ttt.delete_all
Move.delete_all


User.create(name: "Fill", email: "fill@ttt.ttt", password: "123qweasd")
User.create(name: "Bob", email: "bob@ttt.ttt", password: "123qweasd")
User.create(name: "Van", email: "van@ttt.ttt", password: "123qweasd")
User.create(name: "Min", email: "min@ttt.ttt", password: "123qweasd")
User.create(name: "Moll", email: "moll@ttt.ttt", password: "123qweasd")
User.create(name: "Soll", email: "soll@ttt.ttt", password: "123qweasd")
User.create(name: "Goodman", email: "goodman@ttt.ttt", password: "123qweasd")
User.create(name: "Badman", email: "badman@ttt.ttt", password: "123qweasd")
User.create(name: "Noto", email: "noto@ttt.ttt", password: "123qweasd")
User.create(name: "CompAI", email: "ai@ttt.ttt", password: "123qweasd")

p "created #{User.count} users"
p "created #{Ttt.count} game"

