class EventsController < ApplicationController

  
  def index
    @events = Event.all
  end

  
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Événement créé avec succès !'
    else
      render :new
    end
  end


  
  def show
    @event = Event.find(params[:id])
  end




  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end

  
  

  





 
  
end
