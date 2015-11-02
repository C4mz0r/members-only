# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


a = User.create(name: "Alfred", email: "alf@example.com", password: "foobar", password_confirmation: "foobar" )
b = User.create(name: "Bobo", email: "bobo@example.com", password: "foobar", password_confirmation: "foobar" )
c = User.create(name: "Carol", email: "carol@example.com", password: "foobar", password_confirmation: "foobar" )

a.posts.create(title: "I am the best", body: "I am #1.  I rule!")
b.posts.create(title: "So boring", body: "This message board is crappy.")
b.posts.create(title: "Alfred is annoying", body: "He thinks he's so great.  He is so full of himself.  Just shut up, dude.")
c.posts.create(title: "Hey everyone", body: "I am glad to be part of this group")
