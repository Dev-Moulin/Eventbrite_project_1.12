# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

require 'faker'

# Création de 20 utilisateurs
20.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password"
  )
end

# Récupération de tous les utilisateurs créés
users = User.all

# Création de 20 événements, chacun étant administré par un utilisateur aléatoire
20.times do
  Event.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    start_date: Faker::Time.forward(days: 30, period: :evening),
    duration: rand(1..5) * 60, # Durée aléatoire en minutes
    location: Faker::Address.city,
    price: rand(10..100), # Prix entre 10 et 100
    administrator: users.sample # Associe un utilisateur en tant qu'administrateur
  )
end

# Création de participations (Attendance) pour chaque événement
events = Event.all
events.each do |event|
  # Ajoute entre 1 et 10 participants pour chaque événement
  rand(1..10).times do
    Attendance.create!(
      user: users.sample,
      event: event
    )
  end
end

puts "20 utilisateurs, 20 événements et des participations ont été créés avec succès !"
