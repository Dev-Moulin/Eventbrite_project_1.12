# Eventbrite Project

Eventbrite Project est une application web de gestion d'événements, inspirée du site Eventbrite. Elle permet aux utilisateurs de créer des événements, de s'inscrire comme participants, et de gérer leurs participations. Ce projet utilise le framework Ruby on Rails, avec Devise pour l'authentification des utilisateurs et PostgreSQL pour la base de données.

## Fonctionnalités

1. **Authentification** : Gérée par Devise, avec inscription, connexion, récupération de mot de passe et édition de profil.
2. **Création d'événements** : Les utilisateurs peuvent créer des événements avec des informations comme la date de début, la durée, le lieu, le prix, etc. Chaque événement a un administrateur.
3. **Gestion des participations** : Les utilisateurs peuvent participer aux événements via un système de participation.
4. **Affichage des événements** : La page d'accueil présente tous les événements disponibles. Chaque événement peut être consulté individuellement.

## Technologies utilisées

- **Ruby on Rails** : Framework backend pour la création d'applications web.
- **Devise** : Gem pour l'authentification des utilisateurs.
- **PostgreSQL** : Base de données relationnelle.
- **Bootstrap** : Framework CSS pour le design réactif.
- **Faker** : Gem pour générer des données factices lors de l'initialisation de la base de données.

## Prérequis

- Ruby 3.x
- Rails 6.x ou 7.x
- PostgreSQL
- Bundler

## Installation

1. Clonez le repository :
   ```bash
   git clone https://github.com/votre-utilisateur/Eventbrite_project.git
   cd Eventbrite_project
   ```
   
2. Installez les dépendances :
  ```ruby
  bundle install
  ```

3. Créez et configurez la base de données :
  ```ruby
  rails db:create
  rails db:migrate
  ```

4. Initialisez la base de données avec des données factices :
  ```ruby
rails db:seed
  ```

5. Lancez le serveur :
  ```ruby
  rails server
  ```
6. Rendez-vous sur http://localhost:3000 dans votre navigateur pour accéder à l'application.


Structure des Modèles
User
Modèle représentant les utilisateurs inscrits. Les utilisateurs peuvent :

Créer des événements en tant qu'administrateur.
Participer à plusieurs événements via le modèle Attendance.
Event
Modèle représentant les événements créés par les utilisateurs. Un événement :

Appartient à un administrateur (un utilisateur qui a créé l'événement).
Peut avoir plusieurs participants via Attendance.
Inclut des validations pour les attributs tels que start_date, duration, price, etc.
Attendance
Table de jointure entre User et Event. Elle représente la participation d'un utilisateur à un événement spécifique.

Relations des Modèles
User :

has_many :events (en tant qu'administrateur).
has_many :attendances
has_many :participated_events, through: :attendances, source: :event
Event :

belongs_to :administrator, class_name: 'User'
has_many :attendances
has_many :participants, through: :attendances, source: :user
Attendance :

belongs_to :user
belongs_to :event
Fichier seeds.rb
Le fichier db/seeds.rb génère 20 utilisateurs et 20 événements, chacun associé à un administrateur (un utilisateur aléatoire). Il crée également des participations aléatoires pour chaque événement. Cela permet de tester rapidement l'application avec des données réalistes.

Exemple de code pour les seeds :

```ruby
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

# Création de 20 événements, chacun étant administré par un utilisateur aléatoire
20.times do
  Event.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    start_date: Faker::Time.forward(days: 30, period: :evening),
    duration: rand(1..5) * 60, # Durée en minutes
    location: Faker::Address.city,
    price: rand(10..100), # Prix entre 10 et 100
    administrator: User.all.sample
  )
end
```

Déploiement
Pour déployer l'application en production :

Configurez les variables d'environnement pour PostgreSQL, notamment pour le nom d'utilisateur et le mot de passe.
Assurez-vous que Devise est bien configuré pour la production, notamment en définissant config.action_mailer.default_url_options dans config/environments/production.rb.
Contribution
Les contributions sont les bienvenues ! Pour contribuer :

Forkez le projet.
Créez une branche de fonctionnalité (git checkout -b feature/AmazingFeature).
Commitez vos modifications (git commit -m 'Add some amazing feature').
Poussez sur la branche (git push origin feature/AmazingFeature).
Ouvrez une Pull Request.
License
Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

Auteurs
Paul - Développeur principal du projet Eventbrite.

