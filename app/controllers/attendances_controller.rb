class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
  
    if @event.is_free?
      Attendance.create(user: current_user, event: @event)
      redirect_to @event, notice: 'Vous avez rejoint cet événement gratuitement !'
    else
      # Lancer Stripe pour les événements payants
    end
  end

  
end
