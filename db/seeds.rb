# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
    title = Faker::Book.title
    author = Faker::Book.author
    publisher = Faker::Book.publisher
    genre = Faker::Book.genre
  Book.create!(title: title,
               author: author,
               publisher: publisher,
               genre: genre,
               )
end

User.create!(name:  "Naoki Kishimoto",
             email: "naoki@naoki.com",
             password:              "hogehoge",
             password_confirmation: "hogehoge",
             admin: true)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end