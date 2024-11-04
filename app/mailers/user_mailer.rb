class UserMailer < ApplicationMailer
  default from: 'no-reply@eventbrite_project.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur Eventbrite Project !')
  end

  def event_participation_email(event)
    @event = event
    @administrator = event.administrator
    mail(to: @administrator.email, subject: 'Nouvelle participation à votre événement')
  end
end
