# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
u1 = User.create username: "Boolean", latitude: "-33.868820", longitude: "151.209296", password: "chicken", is_admin: false
u2 = User.create username: "Mad Slingshot", latitude: "-33.869795", longitude: "151.206410", password: "chicken", is_admin: false
u3 = User.create username: "Ruler Monarch", latitude: "-33.873157", longitude: "151.206116", password: "chicken", is_admin: false
u4 = User.create username: "chicken",latitude: "-33.873157", longitude: "151.206116", password: "chicken", is_admin: true
<<<<<<< HEAD
u5 = User.create username: "Rudolph 'Poker Face' Holmes", latitude: "40.7143528", longitude: "-74.0059731", password: "chicken", is_admin: false
u6 = User.create username: "Clinton 'Wager' Hendricks", latitude: "40.71916023", longitude: "-73.93180847", password: "chicken", is_admin: false
u7 = User.create username: "Ray 'Hazard' Bush", latitude: "40.58788529", longitude: "-80.08415222", password: "chicken", is_admin: false
u8 = User.create username: "Reuben 'the Demon' McCall", latitude: "40.58788529", longitude: "-80.08415225", password: "chicken", is_admin: false
u9 = User.create username: "Fred 'Smokes' Carr", latitude: "34.7777158", longitude: "-118.89404297", password: "chicken", is_admin: false
u10 = User.create username: "Anton 'Ambush' Durham", latitude: "35.42486792", longitude: "137.1862793", password: "chicken", is_admin: false
=======

>>>>>>> 43c35be992a01f439f160de560ca73a6f818dc98

puts "Created #{ User.all.length } users."

Post.destroy_all
p1 = Post.create question: "What is the meaning of life?", latitude: "-33.869795", longitude: "151.206410", active: true, emjoi: "happy"
p2 = Post.create question: "Where can I buy stuff?", latitude: "-33.891475", longitude: "151.276684", active: false, emjoi: "happy"
p3 = Post.create question: "Any recommendations for cool shit?", latitude: "-33.893340", longitude: "151.204610", active: true, emjoi: "happy"
p4 = Post.create question: "Kyrka-nyckel varg destillery direkt handel ironi estetiska banjo varje dag bär varm kyckling ", latitude: "-33.898340", longitude: "151.204250", active: true, emjoi: "sad"
<<<<<<< HEAD
p5 = Post.create question: "Where is the best food around here bruh? School me bruzzy", latitude: "54.664097", longitude: "-2.752708", active: true, emjoi: "bored"
p6 = Post.create question: "I lost my camera, has anyone found it?", latitude: "34.7777158", longitude: "-118.89404297", active: true, emjoi: "devo"
p7 = Post.create question: "Where can I get a drink?", latitude: "40.71916023", longitude: "-73.93180847", active: true, emjoi: "wasted"
p8 = Post.create question: "When do shops close around here?", latitude: "40.7143528", longitude: "-74.0059731", active: true, emjoi: "devo"
p9 = Post.create question: "What can I do around here on weekends?", latitude: "-33.771500", longitude: "150.906600", active: true, emjoi: "devo"
p10 = Post.create question: "Where can I learn Welsh?", latitude: "45.05800144", longitude: "34.10705566", active: true, emjoi: "thinking"
p11 = Post.create question: "Avez-vous des animaux domestiques?", latitude: "‎48.864716", longitude: "2.349014", active: true, emjoi: "cheeky"
p12 = Post.create question: "La Tour Eiffel est-elle bonne?", latitude: "‎48.864720", longitude: "2.349024", active: true, emjoi: "happy"
p13 = Post.create question: "Quel est le meilleur, étant le patron ou un employé?", latitude: "‎48.864720", longitude: "2.349024", active: true, emjoi: "confused"
p14 = Post.create question: "Où puis-je obtenir un plat maison?", latitude: "‎48.8647215", longitude: "2.349027", active: true, emjoi: "silly"
=======

>>>>>>> 43c35be992a01f439f160de560ca73a6f818dc98

puts "Created #{ Post.all.length } users."

Comment.destroy_all
c1 = Comment.create content: "Westfield has shops"
c2 = Comment.create content: "You should quit your job and learn coding"
c3 = Comment.create content: "My cat's breath smells like cat food"
c4 = Comment.create content: "I like people watching on the streets of barangaroo"
c5 = Comment.create content: "Jogging is fun"
c6 = Comment.create content: "c'est une bonne idée. Fais ça"
c7 = Comment.create content: "Islande vinyle quel que soit l'art partie homme bun portland wolf wayfarers knausgaard paleo réveillé."
c8 = Comment.create content: "Ετικέτα βινύλιο ό, τι καλλιτεχνικό πάρτι άνθρωπος κουνέλι πόρτλαντ λύκος ποδηλάτες knausgaard παλεό ξύπνησε."
c9 = Comment.create content: "cykelrättigheter schlitz skägg av slaktbiprodukter"
c10 = Comment.create content: "långsam-carb tunnelbana kakel bokstavligen"

puts "Created #{ Comment.all.length } users."

u1.posts << p1 << p2
u2.posts << p3 << p4

p1.comments << c2 << c3
p2.comments << c1 << c7 << c8 << c9
p3.comments << c4 << c5 << c6
p4.comments << c10

u1.comments << c4 << c9
u2.comments << c1 << c2
u3.comments << c3 << c7 << c8
u4.comments << c5 << c6 << c10
