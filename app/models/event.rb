
class Event < ApplicationRecord
  belongs_to :administrator, class_name: 'User'
  #Indique que chaque événement a un administrateur 
  #(l’utilisateur qui l’a créé).
  
  has_many :attendances
  #Un événement peut avoir plusieurs participations (Attendance).
  has_many :participants, through: :attendances, source: :user
  #Permet d’obtenir les utilisateurs participants à l’événement.
  #
  validates :start_date, presence: true
  #Cette validation garantit que la start_date 
  #(date de début) de l'événement est toujours renseignée.
  
  validate :start_date_cannot_be_in_the_past
  #Cette validation utilise une méthode définie plus bas dans le code
  # pour s'assurer que la start_date n’est pas dans le passé.
  
  validates :duration, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { only_integer: true, in: 1..1000 }
  validates :location, presence: true

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < DateTime.now
      errors.add(:start_date, "can't be in the past")
    end
  end
  def is_free?
    price == 0
  end
  
  
end
