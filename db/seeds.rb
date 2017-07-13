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


puts "Created #{ User.all.length } users."

Post.destroy_all
p1 = Post.create question: "What is the meaning of life?", latitude: "-33.869795", longitude: "151.206410", active: true, emjoi: "happy"
p2 = Post.create question: "Where can I buy stuff?", latitude: "-33.891475", longitude: "151.276684", active: false, emjoi: "happy"
p3 = Post.create question: "Any recommendations for cool shit?", latitude: "-33.893340", longitude: "151.204610", active: true, emjoi: "happy"
p4 = Post.create question: "Kyrka-nyckel varg destillery direkt handel ironi estetiska banjo varje dag bär varm kyckling ", latitude: "-33.898340", longitude: "151.204250", active: true, emjoi: "sad"


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
