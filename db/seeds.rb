alice = User.create(
  name: "Alice Murphy",
  email: "alice@telamericorp.net",
  password: "imtheboss",
  role: :assistant
)

adam = User.create(
  name: "Adam DeMamp",
  email: "adam@yahoo.com",
  password: "password",
  assistant: alice,
  role: :client
)

blake = User.create(
  name: "Blake Henderson",
  email: "blake@hotmail.com",
  password: "password"
  assistant: alice,
  role: :client
)

anders = User.create(
  name: "Anders Holmvik",
  email: "ders@gmail.com",
  password: "p@ssw0rd"
  assistant: alice,
  role: :client
)
