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
    command = [
      Faker::Hacker.verb.capitalize,
      ["the", "some kind of", "my", "my pet's"].sample,
      Faker::Hacker.adjective,
      Faker::Hacker.noun
    ].join(" ")
    yoda_quote = Faker::Yoda.quote
    client.tasks.create!(
      title: command,
      content: yoda_quote + " But also, don't forget to #{command.downcase}.",
      due_date: Faker::Time.forward(10, :day),
      status: rand(5)
    )
  end
end


# Reminder seeds

User.client.each do |client|
  5.times do
    command = [
      [
        "Hey, it's #{client.assistant.name}.",
        "#{client.assistant.name} here... ",
        "Yo buddy!",
        "Hey dude, gotta remind you about something.",
        "THIS IS IMPORTANT!"
      ].sample,
      [
        "Remember to",
        "Don't forget:",
        "Definitely"
      ].sample,
      Faker::Hacker.verb,
      ["the", "some", "your", "your pet's"].sample,
      Faker::Hacker.noun,
      "if you haven't been",
      Faker::Hacker.ingverb,
      ["lately", "much", "yourself", "enough", "things yet"].sample
    ].join(" ") + "."

    client.reminders.create!(
      content: command,
      task: [client.tasks.sample, nil].sample,
      status: rand(3)
    )
  end
end


# Comment seeds

Task.where("status > 0").each do |task|
  rand(8).times do
    task.comments.create!(
      content: Faker::TwinPeaks.quote,
      author: [task.client, task.assistant].sample || task.client,
      pinned: Faker::Boolean.boolean(0.2),
      edited: Faker::Boolean.boolean(0.1)
    )
  end
end


# Notification seeds

Task.all.each do |task|
  task.notifications.create!(
    content: task.status_message,
    receiver: task.status == "requested" ? task.assistant : task.client,
    status: rand(2)
  )
end

Comment.all.each do |comment|
  comment.audience.notify(comment.task, "#{comment.author.name} commented on '#{comment.task.title}'.")
end

times = Notification.pluck(:created_at).shuffle
Notification.all.each_with_index do |n, i|
  n.created_at = times[i]
  n.save!
end


# Label seeds

labels = %w(phone\ call internet finance relatives email travel paperwork automobile insurance employment)
labels.each { |label| Label.create!(name: label) }
Task.all.each { |task| rand(4).times { task.labels << Label.all.sample } }
