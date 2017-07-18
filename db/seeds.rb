# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
# SYDNEY
u1 = User.create username: "Boolean", latitude: "-33.868820", longitude: "151.209296", password: "chicken", is_admin: false
u2 = User.create username: "Mad Slingshot", latitude: "-33.869795", longitude: "151.206410", password: "chicken", is_admin: false
u3 = User.create username: "Ruler Monarch", latitude: "-33.873157", longitude: "151.206116", password: "chicken", is_admin: false
u4 = User.create username: "chicken", latitude: "-33.873157", longitude: "151.206116", password: "chicken", is_admin: true
u5 = User.create username: "Rudolph 'Poker Face' Holmes", latitude: "40.7143528", longitude: "-74.0059731", password: "chicken", is_admin: false
# NEW YORK
u6 = User.create username: "Clinton 'Wager' Hendricks", latitude: "40.71916023", longitude: "-73.93180847", password: "chicken", is_admin: false
u7 = User.create username: "Ray 'Hazard' Bush", latitude: "40.58788529", longitude: "-80.08415222", password: "chicken", is_admin: false
u8 = User.create username: "Reuben 'the Demon' McCall", latitude: "40.58788529", longitude: "-80.08415225", password: "chicken", is_admin: false
u9 = User.create username: "Fred 'Smokes' Carr", latitude: "34.7777158", longitude: "-118.89404297", password: "chicken", is_admin: false
# PARIS
u10 = User.create username: "Pierre 'Ambush' Durham", latitude: "48.864796", longitude: "2.349014", password: "chicken", is_admin: false
puts "Created #{ User.all.length } users."
Post.destroy_all
# SYDNEY
p1 = Post.create question: "What is the meaning of life?", latitude: "-33.869795", longitude: "151.206410", active: true, emjoi: "happy"
p2 = Post.create question: "Where can I buy stuff?", latitude: "-33.891475", longitude: "151.276684", active: false, emjoi: "happy"
p3 = Post.create question: "Any recommendations for cool shit?", latitude: "-33.893340", longitude: "151.204610", active: true, emjoi: "happy"
p4 = Post.create question: "Kyrka-nyckel varg destillery direkt handel ironi estetiska banjo varje dag bär varm kyckling ", latitude: "-33.898340", longitude: "151.204250", active: true, emjoi: "sad"
p5 = Post.create question: "Where is the best food around here bruh? School me bruzzy", latitude: "54.664097", longitude: "-2.752708", active: true, emjoi: "bored"
# NEW YORK
p6 = Post.create question: "I lost my camera, has anyone found it?", latitude: "40.779437", longitude: "-73.963244", active: true, emjoi: "devo"
p7 = Post.create question: "Where can I get a drink?", latitude: "40.748817", longitude: "-73.985428", active: true, emjoi: "wasted"
p8 = Post.create question: "When do shops close around here?", latitude: "40.777305", longitude: "-73.961401", active: true, emjoi: "devo"
p9 = Post.create question: "What can I do around here on weekends?", latitude: "40.758895", longitude: "-73.985131", active: true, emjoi: "devo"
p10 = Post.create question: "Where can I learn Welsh?", latitude: "40.726477", longitude: "-73.981534", active: true, emjoi: "thinking"
# PARIS
p11 = Post.create question: "Avez-vous des animaux domestiques?", latitude: "48.856614", longitude: "2.352222", active: true, emjoi: "cheeky"
p12 = Post.create question: "La Tour Eiffel est-elle bonne?", latitude: "‎48.858370", longitude: "2.294481", active: true, emjoi: "happy"
p13 = Post.create question: "Quel est le meilleur, étant le patron ou un employé?", latitude: "‎48.860674", longitude: "2.298406", active: true, emjoi: "confused"
p14 = Post.create question: "Où puis-je obtenir un plat maison?", latitude: "‎48.854649", longitude: "2.306292", active: true, emjoi: "silly"
puts "Created #{ Post.all.length } users."
Comment.destroy_all
c1 = Comment.create content: "Westfield has shops"
c2 = Comment.create content: "You should quit your job and learn coding"
c3 = Comment.create content: "My cat's breath smells like cat food"
c4 = Comment.create content: "I like people watching on the streets of barangaroo"
c5 = Comment.create content: "Jogging is fun"
c6 = Comment.create content: "c'est une bonne idée. Fais ça"
c7 = Comment.create content: "Islande vinyle quel que soit l'art partie homme bun portland wolf wayfarers knausgaard paleo réveillé."
c8 = Comment.create content: "Kibby's kebabs is where it's at."
c9 = Comment.create content: "At my mate's place"
c10 = Comment.create content: "Nah I dont think so. I'm way cooler"
c11 = Comment.create content: "That sucks! Macy's has a sale if you need a new one"
c12 = Comment.create content: "I'm sorry to hear that. Fixie polaroid four loko, forage neutra cred enamel pin skateboard vape sartorial 8-bit sustainable meggings hella"
c13 = Comment.create content: "You probably haven't heard of them bicycle rights roof party next level aesthetic"
c14 = Comment.create content: "stumptown enamel pin leggings you probably haven't heard of them man bun XOXO"
c15 = Comment.create content: "Church-key williamsburg la croix fanny pack cronut tacos jianbing gluten-free copper mug "
c16 = Comment.create content: "knausgaard pork belly ethical aesthetic tofu stumptown celiac"
c17 = Comment.create content: "Do you yahoo?"
c18 = Comment.create content: "Shop online, kogi wolf squid vape mustache"
c19 = Comment.create content: "Man braid vice sustainable cred, pork belly pinterest locavore ugh four dollar toast bicycle rights intelligentsia."
c20 = Comment.create content: "Coloring book leggings pabst bitters cray, narwhal meggings viral drinking vinegar pok pok hammock"
c21 = Comment.create content: " Organic sustainable kickstarter, thundercats wolf everyday carry master cleanse 3 wolf moon PBR&B small batch typewriter literally."
c22 = Comment.create content: "Letterpress pickled food truck jean shorts migas, selfies post-ironic microdosing gentrify truffaut air plant woke jianbing. "
c23 = Comment.create content: "Craft beer waistcoat austin succulents"
c23 = Comment.create content: "The Love Boat promises something for everyone. The weather started getting rough - the tiny ship was tossed."
c24 = Comment.create content: "The pub around the corner"
c25 = Comment.create content: "Wales"
c26 = Comment.create content: "YouTube"
c27 = Comment.create content: "'La société n'a pas de sens', dit Marx. Ainsi, le sujet est contextualisé. Dans une théorie culturelle post-textuelle qui comprend la vérité comme une totalité."
c28 = Comment.create content: "Si l'on examine la construction sous-dialectique, on a le choix: Soit rejeter l'expressionnisme, soit conclure que la réalité fait partie de la définition."
c29 = Comment.create content: "Non, il est mauvais de rester à l'écart"
c30 = Comment.create content: "Jus de vert, boucherie, kitsch, nuage, pain"
c31 = Comment.create content: "Oui et non. Ce n'est pas une blague, mais David y est pour quelque chose. Il a créé un programme sans le savoir. "
c32 = Comment.create content: "Il vit sur Internet à travers tout le réseau. Chaque ordinateur connecté connait Prélude."
c33 = Comment.create content: "Je m’en rappellerais si j’avais créé un programme capable de parler. Et puis tiens, je suis en train de taper"
c34 = Comment.create content: "Il y a bien l’amour physique, mais sans les sentiments, cela ressemble davantage à un instinct de reproduction qu’à de l’amour. Un ordinateur n’a pas ce besoin de reproduction. Et pourquoi m’avoir choisi"
puts "Created #{ Comment.all.length } users."
u1.posts << p1 << p2
u2.posts << p3 << p4 << p6
u3.posts << p5 << p11 << p12
u4.posts << p7 << p14
u6.posts << p8 << p10
u10.posts << p9 << p13
p1.comments << c2 << c3
p2.comments << c1
p3.comments << c4 << c5 << c6
p4.comments << c7 << c10
p5.comments << c8 << c9
p6.comments << c11 << c12 << c13
p7.comments << c14 << c15 << c16
p8.comments << c17 << c18
p9.comments << c19 << c20 << c21 << c22 << c23
p10.comments << c24 << c25 << c26
p11.comments << c27 << c28
p12.comments << c29 << c30
p13.comments << c31 << c32
p14.comments << c33 << c34
u1.comments << c4 << c8 << c24
u2.comments << c1 << c2 << c25
u3.comments << c3 << c26
u4.comments << c5 << c6 << c32
u5.comments << c31 << c33 << c7
u6.comments << c22 << c6 << c7 << c30
u7.comments << c11 << c19 << c29
u8.comments << c12 << c18 << c21
u9.comments << c20 << c18 << c23
u10.comments << c13 << c17 << c28 << c15 << c16 << c27 << c34
