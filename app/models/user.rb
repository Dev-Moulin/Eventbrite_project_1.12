class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, foreign_key: 'administrator_id'
  #foreign_key: 'administrator_id' : spécifie que l’attribut 
  #administrator_id dans le modèle Event fait référence à l'utilisateur 
  #qui a créé ou administre cet événement.
  
  has_many :attendances
  #signifie qu'un utilisateur peut avoir plusieurs enregistrements 
  #de participation (Attendance)
  
  has_many :participated_events, through: :attendances, source: :event
  #has_many : chaque utilisateur peut avoir plusieurs enregistrements 
  #dans le modèle Attendance
  #Ici, Attendance est une table de jointure entre User et Event, 
  #représentant la participation d’un utilisateur à un événement.
  #
  #Explication : Cette ligne indique qu'un utilisateur peut participer 
  #à plusieurs événements via le modèle Attendance.
  # has_many :participated_events : l'utilisateur peut participer 
  # à plusieurs événements, mais ces événements sont liés indirectement 
  # via attendances.
  # through: :attendances : spécifie que pour trouver les événements
  #  auxquels l'utilisateur participe, Rails doit d’abord passer par 
  #  le modèle Attendance.
  # source: :event : Rails comprend que la colonne associée dans 
  # attendances fait référence à event.

  validates :email, presence: true, uniqueness: true
  #presence: true : assure que chaque utilisateur doit avoir une 
  #adresse email. Sans email, l’enregistrement ne pourra pas être 
  #sauvegardé.
  ##uniqueness: true : garantit que chaque email est unique dans 
  #la base de données. Deux utilisateurs ne peuvent pas partager 
  #la même adresse email.
  validates :encrypted_password, presence: true
  #Cette validation garantit que chaque utilisateur a bien
  # un mot de passe sécurisé
end
