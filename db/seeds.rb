# User seeds

alice = User.create!(
  name: "Alice Murphy",
  email: "alice@telamericorp.net",
  password: "imtheboss",
  role: :assistant
)

anders = User.create!(
  name: "Anders Holmvik",
  email: "ders@gmail.com",
  password: "p@ssw0rd",
  role: :assistant
)

adam = User.create!(
  name: "Adam DeMamp",
  email: "adam@yahoo.com",
  password: "password",
  assistant: alice,
  role: :client
)

blake = User.create!(
  name: "Blake Henderson",
  email: "blake@hotmail.com",
  password: "password",
  assistant: alice,
  role: :client
)

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    name: "#{first_name} #{last_name}",
    email: Faker::Internet.email(first_name),
    password: Faker::Internet.password,
    assistant: anders,
    role: :client
  )
end


# Task seeds

User.client.each do |client|
  rand(2..10).times do
    yoda_quote = Faker::Yoda.quote
    client.tasks.create!(
      title: yoda_quote.split[0..5].join(" ") + "...",
      content: yoda_quote,
      due_date: Faker::Time.forward(10, :day),
      status: rand(5)
    )
  end
end


# Notification seeds

Task.accepted.each do |task|
  task.notifications.create!(
    content: task.status_message,
    receiver: [task.client, task.client, task.client, task.assistant].sample,
    status: rand(3)
  )
end

Task.in_progress.each do |task|
  task.notifications.create!(
    content: task.status_message,
    receiver: [task.client, task.client, task.client, task.assistant].sample,
    status: rand(3)
  )
end

Task.completed.each do |task|
  task.notifications.create!(
    content: task.status_message,
    receiver: [task.client, task.client, task.client, task.assistant].sample,
    status: rand(3)
  )
end


# Reminder seeds

User.client.each do |client|
  rand(5).times do
    client.reminders.create!(
      content: "Hey, it's #{client.assistant.name}. Remember to #{Faker::Hipster.sentence.downcase}",
      task: [client.tasks.sample, nil].sample,
      status: rand(3)
    )
  end
end


# Comment seeds

Task.where("status > 0").each do |task|
  rand(5).times do
    task.comments.create!(
      content: Faker::TwinPeaks.quote,
      author: [task.client, task.assistant].sample || task.client,
      pinned: Faker::Boolean.boolean(0.2),
      edited: Faker::Boolean.boolean(0.1)
    )
  end
end


# Label seeds

10.times { Label.create!(name: Faker::Company.unique.buzzword) }
Task.all.each { |task| rand(4).times { task.labels << Label.all.sample } }
