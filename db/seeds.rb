# Users

jaimie = User.create(name: "Jaimie", email: "jaimietn@gmail.com")
evan = User.create(name: "Evan", email: "evans@gmail.com")
ariel = User.create(name: "Ariel", email: "ariel@gmail.com")

# Books

UserBook.create(user: jaimie, book_id: "-rUACwAAQBAJ")
UserBook.create(user: jaimie, book_id: "AeXdmwEACAAJ")
