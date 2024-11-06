class CheckoutController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          unit_amount: (@event.price * 100).to_i, # Conversion en cents
          product_data: { name: @event.title }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
      metadata: { event_id: @event.id }
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    event_id = session.metadata.event_id
    event = Event.find(event_id)

    # Crée une nouvelle participation
    Attendance.create(user: current_user, event: event, stripe_customer_id: session.customer)
  end

  def cancel
    # Redirige l'utilisateur avec un message d'échec
    redirect_to root_path, alert: "Le paiement a été annulé."
  end
end
