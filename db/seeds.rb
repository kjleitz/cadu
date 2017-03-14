alice = User.create(
  name: "Alice Murphy",
  email: "alice@telamericorp.net",
  password: "imtheboss",
  role: :assistant
)

anders = User.create(
  name: "Anders Holmvik",
  email: "ders@gmail.com",
  password: "p@ssw0rd"
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

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    name: "#{first_name} #{last_name}",
    email: Faker::Internet.email(first_name),
    password: Faker::Internet.password,
    assistant: anders,
    role: :client
  )
end
